//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

open class VCTabledViewController: VCViewController {
    @IBOutlet open var tableView: UITableView!

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.includesRefreshControl {
            self.refreshControlManager.setupRefreshControl(scrollView: self.tableView)
        }
        
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
    
    // MARK: - Data Loading
    /** Reloads TableView Data */
    open func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - Placeholders
    open override func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 drawer: VCDrawerProtocol? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) {
        self.tableView.refreshControl?.endRefreshing()
        
        self.tableView.isHidden = enable
        
        super.updatePlaceholders(enable: enable,
                                 title: title,
                                 text: text,
                                 drawer: drawer,
                                 activity: activity,
                                 buttonTitle: buttonTitle)
    }
    
    // MARK: - SearchControlManagerDelegate
    open override func searchControlDidBeginEditing(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.tableView.bounces = false
            self.tableView.alwaysBounceVertical = false
        }
    }
    open override func searchControlCancelButtonPressed(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.tableView.bounces = true
            self.tableView.alwaysBounceVertical = true
        }
    }
}

// MARK: - UITableViewDataSource
extension VCTabledViewController: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}

// MARK: - UITableViewDelegate
extension VCTabledViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
