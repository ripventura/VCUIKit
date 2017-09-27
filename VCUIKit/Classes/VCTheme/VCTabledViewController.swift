//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

@IBDesignable open class VCTabledViewController: VCViewController {
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
    
    // Used to disable the RefreshControl when Searching
    var bounce: Bool?
    var alwaysBounceVertical: Bool?
    
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
                                 image: UIImage? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) {
        self.tableView.refreshControl?.endRefreshing()
        
        self.tableView.isHidden = enable
        
        self.placeholderView.update(enable: enable,
                                    title: title,
                                    text: text,
                                    image: image,
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
        
        searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
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
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

