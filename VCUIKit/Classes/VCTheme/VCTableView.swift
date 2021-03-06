//
//  TableView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCTableView: UITableView {
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    /** Whether this TableView should react to keyboard notifications. Use only under a UIViewController.
     UITableViewController already does this by default. */
    @IBInspectable var reactToKeyboard: Bool = true
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.applyAppearance()
        
        self.setupNotifications()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
        
        self.setupNotifications()
    }
    
    deinit {
        self.removeNotifications()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.backgroundColor = sharedAppearanceManager.appearance.tableViewBackgroundColor
            self.separatorColor = sharedAppearanceManager.appearance.tableViewSeparatorColor
        }
    }
    
    // MARK: - Keyboard Notifications
    
    // Listens for Keyboard notifications
    func setupNotifications() -> Void {
        if self.reactToKeyboard {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        }
    }
    
    // Removes Keyboard notifications
    func removeNotifications() -> Void {
        if self.reactToKeyboard {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        }
    }
    
    @objc private func keyboardDidShow(notification : NSNotification) {
        let keyboardHeight : CGFloat = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size.height
        
        self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom >= keyboardHeight ? self.contentInset.bottom : self.contentInset.bottom + keyboardHeight, self.contentInset.right)
    }
    
    @objc private func keyboardDidHide(notification : NSNotification) {
        let keyboardHeight : CGFloat = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size.height
        
        self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom >= keyboardHeight ? self.contentInset.bottom - keyboardHeight : self.contentInset.bottom, self.contentInset.right)
    }
}

