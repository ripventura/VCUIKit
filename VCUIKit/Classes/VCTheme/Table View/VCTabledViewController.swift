//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

open class VCTabledViewController: VCViewController, RefreshControlManagerDelegate, SearchControlManagerDelegate {
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Whether the TableView should disable the RefreshControl when searching */
    @IBInspectable open var disablesRefreshWhenSearching: Bool = true
    
    open var refreshControlManager: RefreshControlManager = RefreshControlManager()
    open var searchControlManager: SearchControlManager = SearchControlManager()
    
    @IBOutlet open var tableView: UITableView!
    
    @IBOutlet open var placeholderView: VCPlaceholderView?
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControlManager.delegate = self
        if self.includesRefreshControl {
            self.refreshControlManager.setupRefreshControl(scrollView: self.tableView)
        }
        
        self.searchControlManager.delegate = self
        if self.includesSearchControl {
            self.searchControlManager.setupSearchControl(viewController: self)
        }
        
        self.setupPlaceholders()
        
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
    }
    
    // MARK: - Styling
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        self.searchControlManager.searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        self.placeholderView?.applyAppearance()
    }
    
    // MARK: - Placeholders
    /** Sets up the placeholders */
    private func setupPlaceholders() {
        if self.placeholderView == nil {
            placeholderView = VCPlaceholderView(frame: CGRectDefault)
            self.view.addSubview(placeholderView!)
            self.view.sendSubview(toBack: placeholderView!)
            placeholderView!.snp.makeConstraints({make in
                make.edges.equalToSuperview()
            })
        }
        placeholderView!.setup(actionHandler: {
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
        
        self.placeholderView?.update(enable: enable,
                                     title: title,
                                     text: text,
                                     drawer: drawer,
                                     activity: activity,
                                     buttonTitle: buttonTitle)
    }
    
    /** Called after the placeHolderActionButton is pressed */
    open func placeholderActionButtonPressed() {
        
    }
    
    // MARK: - RefreshControlManagerDelegate
    open func refreshControlDidRefresh(manager: RefreshControlManager) {
    }
    
    // MARK: - SearchControlManagerDelegate
    open func searchControlDidBeginEditing(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.tableView.bounces = false
            self.tableView.alwaysBounceVertical = false
        }
    }
    
    open func searchControlCancelButtonPressed(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.tableView.bounces = true
            self.tableView.alwaysBounceVertical = true
        }
    }
    
    open func searchControl(manager: SearchControlManager, didSearch text: String?) {
    }

    // MARK: - Data Loading
    
    /** Reloads TableView Data */
    open func reloadData() {
        self.tableView.reloadData()
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
