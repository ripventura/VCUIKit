//
//  TableView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCTableView: UITableView {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable open var storyboardAppearance: Bool = false
    /** Wheter this TableView should have a RefreshControl (iOS >= 10.0) */
    @IBInspectable open var hasRefreshControl: Bool = false
    
    open var refreshDelegate: VCTableViewRefreshDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.applyAppearance()
        
        self.setupNotifications()
        
        if #available(iOS 10.0, *) {
            self.setupRefreshControl()
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.applyAppearance()
        
        self.setupNotifications()
        
        if #available(iOS 10.0, *) {
            self.setupRefreshControl()
        }
    }
    
    deinit {
        self.removeNotifications()
    }
    
    override func applyAppearance() -> Void {
        if !storyboardAppearance {
            self.backgroundColor = sharedAppearanceManager.tableViewBackgroundColor
        }
    }
    
    // MARK: - Refresh Control
    
    @available(iOS 10.0, *)
    internal func setupRefreshControl() -> Void {
        if self.hasRefreshControl {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.addTarget(self, action: #selector(self.didRefreshControl), for: .valueChanged)
        }
    }
    
    internal func didRefreshControl() -> Void {
        if #available(iOS 10.0, *) {
            self.refreshControl?.beginRefreshing()
            self.refreshDelegate?.tableViewDidRefreshControl(tableView: self)
        }
    }
    
    // MARK: - Keyboard Notifications
    
    // Listens for Keyboard notifications
    func setupNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    // Removes Keyboard notifications
    func removeNotifications() -> Void {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
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

public protocol VCTableViewRefreshDelegate {
    func tableViewDidRefreshControl(tableView: VCTableView)
}
