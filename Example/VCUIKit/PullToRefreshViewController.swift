//
//  PullToRefreshViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/06/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import VCUIKit

class PullToRefreshViewController: VCTableViewController {
    var count: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didRefreshControl() {
        if self.count > 0 {
            self.count = 0
            self.updatePlaceholders(enable: true,
                                    title: "Placeholder Title",
                                    text: "Placeholder text...",
                                    image: nil,
                                    activity: true,
                                    buttonTitle: "Touch me")
        }
        else {
            self.count = 20
            self.updatePlaceholders(enable: false)
        }
        self.reloadData()
        
        self.refreshControl?.endRefreshing()
    }
    
    override func placeholderActionButtonPressed(_ sender: Any) {
        print("You touched it!")
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VCTableViewCell(frame: CGRectDefault)
        cell.textLabel?.text = "Pull to Refresh"
        return cell
    }
}
