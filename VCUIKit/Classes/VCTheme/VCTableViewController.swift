//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

@IBDesignable open class VCTableViewController: UIViewController {
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Whether the TableView should disable the RefreshControl when searching */
    @IBInspectable open var disablesRefreshWhenSearching: Bool = true
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable open var storyboardAppearance: Bool = false
    
    /** Main TableView */
    @IBOutlet open var tableView: UITableView!
    
    open var backgroundView: UIView = UIView()
    open var placeHolderImageView : VCImageView = VCImageView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeholderTitleLabel : VCLabel = VCLabel()
    open var placeHolderTextLabel : VCLabel = VCLabel()
    open var placeHolderActionButton : VCButton = VCButton()
    
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // Used on iOS <= 10 to hide rightBarButtonItems when searching
    var rightButtonItems: [UIBarButtonItem]?
    
    // Used to disable the RefreshControl when Searching
    var bounce: Bool?
    var alwaysBounceVertical: Bool?
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    /** Sets up the placeholders on the tableView.backgroundView */
    private func setupPlaceholders() {
        let centerYOffset = -80
        
        backgroundView = UIView(frame: CGRectDefault)
        backgroundView.backgroundColor = .clear
        self.view.addSubview(backgroundView)
        self.view.sendSubview(toBack: backgroundView)
        backgroundView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        backgroundView.addSubview(self.placeHolderImageView)
        placeHolderImageView.snp.makeConstraints({make in
            make.centerX.equalTo(backgroundView)
            make.bottom.equalTo(backgroundView.snp.centerY).offset(centerYOffset)
            make.width.equalTo(100)
            make.height.equalTo(100)
        })
        
        backgroundView.addSubview(self.placeHolderActivityIndicatorView)
        self.placeHolderActivityIndicatorView.hidesWhenStopped = true
        placeHolderActivityIndicatorView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeHolderImageView)
            make.centerY.equalTo(self.placeHolderImageView)
        })
        
        self.placeholderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleColor
        self.placeholderTitleLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleFont
        self.placeholderTitleLabel.textAlignment = .center
        self.placeholderTitleLabel.numberOfLines = 0
        backgroundView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(backgroundView)
            make.right.equalTo(backgroundView)
            make.top.equalTo(backgroundView.snp.centerY).offset(centerYOffset + 20)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        backgroundView.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(backgroundView)
            make.right.equalTo(backgroundView)
            make.top.equalTo(self.placeholderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        backgroundView.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.placeholderActionButtonPressed(_:)), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
    }
    
    /** Updates the placeholders */
    open func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 image: UIImage? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) -> Void {
        self.backgroundView.isHidden = !enable
        
        self.placeholderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderImageView.image = image
        if activity {
            self.placeHolderActivityIndicatorView.startAnimating()
        } else {
            self.placeHolderActivityIndicatorView.stopAnimating()
        }
        self.placeHolderActionButton.setTitle(buttonTitle, for: .normal)
        self.placeHolderActionButton.isHidden = buttonTitle == nil
    }
    
    /** Called after the placeHolderActionButton is pressed */
    @objc open func placeholderActionButtonPressed(_ sender: Any) -> Void {
        
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
            // Stores for later use
            self.bounce = self.tableView.bounces
            self.alwaysBounceVertical = self.tableView.alwaysBounceVertical
            
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
            self.tableView.bounces = self.bounce!
            self.tableView.alwaysBounceVertical = self.alwaysBounceVertical!
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
        
        if #available(iOS 11.0, *) {
            if self.includesSearchControl {
                self.tableView.refreshControl?.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
            }
            if self.includesRefreshControl {
                // This is needed to fix a bug on iOS 11 where refreshControls brake when refreshing
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
        
        searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
    }
}
extension VCTableViewController: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.didSearch(text: searchController.searchBar.text)
    }
}
extension VCTableViewController: UISearchBarDelegate {
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.didStartSearching()
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didCancelSearch()
    }
}

extension VCTableViewController: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}
extension VCTableViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

