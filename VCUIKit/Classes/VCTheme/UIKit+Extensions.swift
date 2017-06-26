//
//  VCThemedViewController.swift
//  VCSwiftLibrary
//
//  Created by Vitor Cesco on 12/1/15.
//  Copyright © 2015 Vitor Cesco. All rights reserved.
//

import UIKit
import SnapKit

extension UITextField {
    
    /** Sets a Done Toolbar as InputAccessoryView */
    open func shouldUseDoneToolbar(shouldUse : Bool) {
        if !shouldUse {
            self.inputAccessoryView = nil
        }
        else {
            let keyboardDoneButtonShow = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
            keyboardDoneButtonShow.barStyle = .default
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(resignFirstResponder))
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            keyboardDoneButtonShow.setItems([flexSpace,doneButton], animated: false)
            
            self.inputAccessoryView = keyboardDoneButtonShow
        }
    }
}

extension UIView {
    /** Adds the view to the given superview applying the given constraints insets */
    open func addToSuperViewWithConstraints(superview : UIView, constraintInset : UIEdgeInsets) {
        self.addToSuperView(superview: superview)
        
        self.snp.makeConstraints({ make in
            make.edges.equalTo(self.superview!).inset(constraintInset)
        })
    }
    
    /** Adds the view to the given superview */
    open func addToSuperView(superview : UIView) {
        superview.addSubview(self)
    }
    
    /** Applies the custom appearance on this UIView */
    internal func applyAppearance() -> Void {
    }
}

extension UIViewController {
    
    /** Sets the NavigationBar Title */
    open func setNavitagionBarTitle(title : String) {
        self.navigationItem.title = title
    }
    
    /** Adds a UIBarButtomItem to the RightItems on the NavigationBar */
    open func addButtomItemToNavigationBarRightItems(buttomItem : UIBarButtonItem) {
        var array = self.navigationItem.rightBarButtonItems
        if array == nil {
            array = []
        }
        array?.append(buttomItem)
        self.navigationItem.rightBarButtonItems = array
    }
    
    /** Adds a UIBarButtomItem to the LeftItems on the NavigationBar */
    open func addButtomItemToNavigationBarLeftItems(buttomItem : UIBarButtonItem) {
        var array = self.navigationItem.leftBarButtonItems
        if array == nil {
            array = []
        }
        array?.append(buttomItem)
        self.navigationItem.leftBarButtonItems = array
    }
    
    /** Resigns all views firstResponder */
    open func resignViewsFirstResponder() {
        self.view.endEditing(true)
    }
    
    internal func updateBackButtonStyle() {
        //Updates the BackButton Style
        let backButton = UIBarButtonItem()
        backButton.title = sharedAppearanceManager.navigationBarBackButtonTitle
        
        self.navigationItem.backBarButtonItem = backButton
    }
    
    /** Applies the custom appearance on this UIView */
    internal func applyAppearance() -> Void {
    }
}

extension UITabBarController {
    
    override func applyAppearance() {
        //Updates Navbar Tint Color
        self.tabBar.tintColor = sharedAppearanceManager.tabBarTintColor
        
        self.tabBar.isTranslucent = sharedAppearanceManager.tabBarIsTranslucent
        
        if let items = self.tabBar.items {
            for item in items {
                item.setTitleTextAttributes([NSFontAttributeName: sharedAppearanceManager.tabBarFont], for: .normal)
            }
        }
    }
}

extension UINavigationController {
    
    override func applyAppearance() {
        self.navigationBar.isTranslucent = sharedAppearanceManager.navigationBarIsTranslucent
        
        //Updates Navbar Tint Color
        self.navigationBar.tintColor = sharedAppearanceManager.navigationBarTintColor
        
        //Updates Navbar Background Color
        self.navigationBar.barTintColor = sharedAppearanceManager.navigationBarBackgroundColor
        
        //Updates NavigationBar title font
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: sharedAppearanceManager.navigationBarTitleColor,
            NSFontAttributeName: sharedAppearanceManager.navigationBarTitleFont
        ]
    }
}
