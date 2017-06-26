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
    @IBInspectable var storyboardAppearance: Bool = false {
        didSet {
            self.applyAppearance()
        }
    }
    /** Wheter this TableView should have a RefreshControl */
    @IBInspectable open var pullToRefresh: Bool = false {
        didSet {
            self.setupRefreshControl()
        }
    }
    
    open var pullRefreshControl: UIRefreshControl?
    open var refreshDelegate: VCTableViewRefreshDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.applyAppearance()
        
        self.setupNotifications()
        
        self.setupRefreshControl()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
        
        self.setupNotifications()
        
        self.setupRefreshControl()
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
    
    internal func setupRefreshControl() -> Void {
        if self.pullToRefresh {
            self.pullRefreshControl = UIRefreshControl()
            self.pullRefreshControl?.addTarget(self, action: #selector(self.didRefreshControl), for: .valueChanged)
            self.addSubview(self.pullRefreshControl!)
        }
    }
    
    internal func didRefreshControl() -> Void {
        self.pullRefreshControl?.beginRefreshing()
        self.refreshDelegate?.tableViewDidPullToRefresh(tableView: self)
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
    func tableViewDidPullToRefresh(tableView: VCTableView)
}
