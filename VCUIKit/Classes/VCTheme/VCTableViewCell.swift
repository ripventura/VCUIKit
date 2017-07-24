//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCTableViewCell: UITableViewCell {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.applyAppearance()
        self.listenToAppearanceNotifications()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
        self.listenToAppearanceNotifications()
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    deinit {
        self.removeAppearanceNotifications()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.contentView.backgroundColor = sharedAppearanceManager.appearance.tableViewCellBackgroundColor
            self.backgroundColor = sharedAppearanceManager.appearance.tableViewCellBackgroundColor
            
            self.textLabel?.textColor = sharedAppearanceManager.appearance.tableViewCellTitleTextColor
            self.textLabel?.font = sharedAppearanceManager.appearance.tableViewCellTitleFont
            
            self.detailTextLabel?.textColor = sharedAppearanceManager.appearance.tableViewCellDetailTextColor
            self.textLabel?.font = sharedAppearanceManager.appearance.tableViewCellDetailFont
            
            self.tintColor = sharedAppearanceManager.appearance.tableViewCellTintColor
        }
    }
}
