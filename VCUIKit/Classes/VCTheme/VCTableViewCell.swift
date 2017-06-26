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
    @IBInspectable var storyboardAppearance: Bool = false {
        didSet {
            self.applyAppearance()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.applyAppearance()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
    }
    
    override func applyAppearance() -> Void {
        if !storyboardAppearance {
            self.contentView.backgroundColor = sharedAppearanceManager.tableViewCellBackgroundColor
            self.backgroundColor = sharedAppearanceManager.tableViewCellBackgroundColor
            
            self.textLabel?.textColor = sharedAppearanceManager.tableViewCellTitleTextColor
            self.textLabel?.font = sharedAppearanceManager.tableViewCellTitleFont
            
            self.detailTextLabel?.textColor = sharedAppearanceManager.tableViewCellDetailTextColor
            self.textLabel?.font = sharedAppearanceManager.tableViewCellDetailFont
            
            self.tintColor = sharedAppearanceManager.tableViewCellTintColor
        }
    }
}
