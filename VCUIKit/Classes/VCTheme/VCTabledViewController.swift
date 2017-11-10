//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

open class VCTabledViewController: VCViewController {
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Whether the TableView should disable the RefreshControl when searching */
    @IBInspectable open var disablesRefreshWhenSearching: Bool = true
    
    /** Main TableView */
    @IBOutlet open var tableView: UITableView!
    
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    open var placeholderView: VCPlaceholderView = VCPlaceholderView()
    
    // Used on iOS <= 10 to hide rightBarButtonItems when searching
    var rightButtonItems: [UIBarButtonItem]?
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // If this viewController isTranslucent and doesn't includesRefreshControl
        if self.navigationController?.navigationBar != nil &&
            self.navigationController!.navigationBar.isTranslucent &&
            !self.includesRefreshControl {
            if #available(iOS 11, *) {
            }
            else {
                // Adds an inset to compensate the translucent navigation bar on iOS 10-
                self.tableView.contentInset = UIEdgeInsets(top: self.tableView.contentInset.top + 64,
                                                           left: self.tableView.contentInset.left,
                                                           bottom: self.tableView.contentInset.bottom,
                                                           right: self.tableView.contentInset.right)
            }
        }
        
        self.setupPlaceholders()
        self.setupSearchControl()
        self.setupRefreshControl()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Auto includes the SearchBar on iOS <= 10
        if #available(iOS 11, *) {
        }
        else {
            // If includesSearchControl
            if self.includesSearchControl {
                // If the SearchControl isn't loaded yet
                if self.navigationItem.titleView != searchController.searchBar {
                    self.setNavitagionBarTitle(view: searchController.searchBar)
                }
            }
        }
    }
    
    // MARK: - Placeholders
    
    /** Sets up the placeholders */
    private func setupPlaceholders() {
        placeholderView = VCPlaceholderView(frame: CGRectDefault)
        self.view.addSubview(placeholderView)
        self.view.sendSubview(toBack: placeholderView)
        placeholderView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        placeholderView.setup(actionHandler: {
            self.placeholderActionButtonPressed()
        })
    }
    
    /** Update ths PlaceholderView */
    open func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 drawer: VCDrawerProtocol? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) {
        self.tableView.refreshControl?.endRefreshing()
        
        self.tableView.isHidden = enable
        
        self.placeholderView.update(enable: enable,
                                    title: title,
                                    text: text,
                                    drawer: drawer,
                                    activity: activity,
                                    buttonTitle: buttonTitle)
    }
    
    /** Called after the placeHolderActionButton is pressed */
    open func placeholderActionButtonPressed() {
        
    }
    
    // MARK: - Refresh Control
    
    internal func setupRefreshControl() -> Void {
        if self.includesRefreshControl {
            self.tableView.refreshControl = UIRefreshControl()
            self.tableView.refreshControl?.addTarget(self, action: #selector(self.refreshControlTriggered), for: .valueChanged)
        }
    }
    @objc fileprivate func refreshControlTriggered() {
        if self.tableView!.refreshControl!.isRefreshing {
            self.didRefreshControl()
        }
    }
    /** Called after the RefreshControl is triggered */
    open func didRefreshControl() -> Void {
    }
    
    // MARK: - Search Control
    
    /** Sets up the SearchControl. Override this calling super for any custom properties. */
    open func setupSearchControl() -> Void {
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.showsCancelButton = false
        // Good practice
        definesPresentationContext = false
        
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = true
            
            if self.includesSearchControl {
                self.navigationItem.searchController = self.searchController
            }
        }
        else {
            self.searchController.hidesNavigationBarDuringPresentation = false
        }
    }
    
    /** Sets the SearchControl active/inactive */
    open func setSearchControl(active: Bool) {
        // If the SearchControl was active and is now being disabled
        if self.searchController.isActive && !active {
            self.didCancelSearch()
        }
        self.searchController.isActive = active
    }
    
    /** Called after the SearchControl updates it's text */
    open func didSearch(text: String?) {
        
    }
    
    /** Called after the SearchControl becomes active */
    open func didStartSearching() {
        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.tableView.bounces = false
            self.tableView.alwaysBounceVertical = false
        }
        // This appearance has to be fixed after the bar starts editing (iOS 11 bug)
        if let textField = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if #available(iOS 11.0, *) {
                textField.textColor = sharedAppearanceManager.appearance.navigationBarTitleColor
            }
            else {
                textField.textColor = .darkText
                textField.tintColor = .gray
            }
        }
        
        if #available(iOS 11.0, *) {
        }
        else {
            self.rightButtonItems = self.navigationItem.rightBarButtonItems
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    /** Called after the SearchControl becomes inactive */
    open func didCancelSearch() {
        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.tableView.bounces = true
            self.tableView.alwaysBounceVertical = true
        }
        
        if #available(iOS 11.0, *) {
        }
        else {
            self.navigationItem.rightBarButtonItems = self.rightButtonItems
            self.rightButtonItems = nil
        }
    }
    
    // MARK: - Data Loading
    
    /** Reloads TableView Data */
    open func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - Styling
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        self.placeholderView.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeholderView.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeholderView.placeHolderTitleLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleColor
        self.placeholderView.placeHolderTitleLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleFont
        self.placeholderView.placeHolderDrawableView.snp.updateConstraints({make in
            make.size.equalTo(sharedAppearanceManager.appearance.tabledViewControllerPlaceholderImageSize)
        })
    }
}
extension VCTabledViewController: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.didSearch(text: searchController.searchBar.text)
    }
}
extension VCTabledViewController: UISearchBarDelegate {
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.didStartSearching()
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didCancelSearch()
    }
}

extension VCTabledViewController: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}
extension VCTabledViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

open class VCPlaceholderView: VCView {
    open var placeHolderDrawableView : VCDrawableView = VCDrawableView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeHolderTitleLabel : VCLabel = VCLabel()
    open var placeHolderTextLabel : VCLabel = VCLabel()
    open var placeHolderActionButton : VCButton = VCButton()
    
    var actionHandler: (() -> Void)?
    
    open var isEnabled: Bool {
        get {
            return !self.isHidden
        }
        set(newValue) {
            self.isHidden = !newValue
        }
    }
    
    /** Updates the placeholders */
    open func update(enable: Bool,
                     title: String? = nil,
                     text: String? = nil,
                     drawer: VCDrawerProtocol? = nil,
                     activity: Bool = false,
                     buttonTitle: String? = nil) {
        self.isEnabled = enable
        self.placeHolderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderDrawableView.drawer = drawer
        if activity {
            self.placeHolderActivityIndicatorView.startAnimating()
        } else {
            self.placeHolderActivityIndicatorView.stopAnimating()
        }
        self.placeHolderActionButton.setTitle(buttonTitle, for: .normal)
        self.placeHolderActionButton.isHidden = buttonTitle == nil
    }
    
    /** Sets up the PlaceholderView */
    open func setup(actionHandler: @escaping (() -> Void)) {
        self.actionHandler = actionHandler
        
        self.backgroundColor = .clear
        
        let centerYOffset = -80
        
        self.placeHolderDrawableView.backgroundColor = .clear
        self.addSubview(self.placeHolderDrawableView)
        placeHolderDrawableView.snp.makeConstraints({make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).offset(centerYOffset)
            make.size.equalTo(sharedAppearanceManager.appearance.tabledViewControllerPlaceholderImageSize)
        })
        
        self.addSubview(self.placeHolderActivityIndicatorView)
        self.placeHolderActivityIndicatorView.hidesWhenStopped = true
        placeHolderActivityIndicatorView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeHolderDrawableView)
            make.centerY.equalTo(self.placeHolderDrawableView)
        })
        
        self.placeHolderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTitleLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleColor
        self.placeHolderTitleLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleFont
        self.placeHolderTitleLabel.textAlignment = .center
        self.placeHolderTitleLabel.numberOfLines = 0
        self.addSubview(self.placeHolderTitleLabel)
        placeHolderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.snp.centerY).offset(centerYOffset + 20)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        self.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.placeHolderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        self.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.actionButtonPressed), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
        
        self.isEnabled = false
    }
    
    @objc fileprivate func actionButtonPressed() {
        self.actionHandler?()
    }
}

