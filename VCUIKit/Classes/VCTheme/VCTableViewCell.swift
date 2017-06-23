//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCTableViewCell: UITableViewCell {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.applyAppearance()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.applyAppearance()
    }
    
    override func applyAppearance() -> Void {
        if !storyboardAppearance {
            self.contentView.backgroundColor = sharedStyleManager.tableViewCellBackgroundColor
            self.backgroundColor = sharedStyleManager.tableViewCellBackgroundColor
            
            self.textLabel?.textColor = sharedStyleManager.tableViewCellTitleTextColor
            self.textLabel?.font = sharedStyleManager.tableViewCellTitleFont
            
            self.detailTextLabel?.textColor = sharedStyleManager.tableViewCellDetailTextColor
            self.textLabel?.font = sharedStyleManager.tableViewCellDetailFont
            
            self.tintColor = sharedStyleManager.tableViewCellTintColor
        }
    }
}
