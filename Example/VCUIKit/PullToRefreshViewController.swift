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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func refreshControlDidRefresh(manager: RefreshControlManager) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            
            self.updatePlaceholders(enable: true,
                                    title: "Some title here",
                                    text: "Try refreshing your data",
                                    buttonTitle: "Refresh")
        })
    }
    
    override func placeholderActionButtonPressed() {
        self.updatePlaceholders(enable: true,
                                title: "Refreshing data",
                                text: "Hang on...",
                                activity: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            self.updatePlaceholders(enable: false)
        })
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
