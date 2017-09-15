//
//  PullToRefreshViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/06/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import VCUIKit

class PullToRefreshViewController: VCTabledViewController {
    
    var isSearchEnabled: Bool = false
    
    override func didPullRefreshControl() {
        print("Did pull to refresh!")
        self.pullRefreshControl?.endRefreshing()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        self.searchControl(enable: !isSearchEnabled)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VCTableViewCell(frame: CGRectDefault)
        cell.textLabel?.text = "Pull to Refresh"
        return cell
    }
}
