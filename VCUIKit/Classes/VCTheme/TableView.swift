//
//  TableView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit
import PullToRefreshSwift

@IBDesignable open class VCTableView: UITableView {
    var tableViewBackgroundColor : UIColor = sharedStyleManager.tableViewBackgroundColor
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        _ = self.applyThemeStyle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _ = self.applyThemeStyle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    // Applies Theme Style after loading
    func applyThemeStyle() {
        self.backgroundColor = tableViewBackgroundColor
    }
    
    /** Adds a Pull to Refresh handler **/
    public func pullToRefresh(handler : @escaping (Void) -> (Void)) {
        self.addPullRefresh(refreshCompletion: {
            handler()
            self.stopPullRefreshEver()
        })
    }
    
    /** Adds a Push to Refresh handler **/
    public func pushToRefresh(handler : @escaping (Void) -> (Void)) {
        self.addPushRefresh(refreshCompletion: {
            handler()
            self.stopPushRefreshEver()
        })
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
