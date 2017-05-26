//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCTableViewCell: UITableViewCell {
    
    @IBInspectable var tableViewCellTintColor : UIColor = sharedStyleManager.tableViewCellTintColor
    @IBInspectable var tableViewCellBackgroundColor : UIColor = sharedStyleManager.tableViewCellBackgroundColor
    @IBInspectable var tableViewCellTitleTextColor : UIColor = sharedStyleManager.tableViewCellTitleTextColor
    @IBInspectable var tableViewCellDetailTextColor : UIColor = sharedStyleManager.tableViewCellDetailTextColor
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _ = self.applyThemeStyle()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _ = self.applyThemeStyle()
    }
    
    // Applies Theme Style after loading
    func applyThemeStyle() {
        self.contentView.backgroundColor = tableViewCellBackgroundColor
        self.backgroundColor = tableViewCellBackgroundColor
        
        self.textLabel?.textColor = tableViewCellTitleTextColor
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.minimumScaleFactor = 0.7
        self.textLabel?.numberOfLines = 2
        
        self.detailTextLabel?.textColor = tableViewCellDetailTextColor
        self.detailTextLabel?.adjustsFontSizeToFitWidth = true
        self.detailTextLabel?.minimumScaleFactor = 0.7
        
        self.tintColor = tableViewCellTintColor
    }
}
