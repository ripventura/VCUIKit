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
    /** View's Corner Radius */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    /** View's Border Width */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    /** View's Border Color */
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /** Adds the View to a given UIView, creating constraints based on the UIEdgeInsets */
    func addTo(superView: UIView, withConstraint constraintInset: UIEdgeInsets) -> Void {
        
        superView.addSubview(self)
        
        /*let horizonalContraintLeft = NSLayoutConstraint(item: self,
         attribute: .leadingMargin,
         relatedBy: .equal,
         toItem: superView,
         attribute: .leadingMargin,
         multiplier: 1.0,
         constant: constraintInset.left)
         
         let horizonalContraintRight = NSLayoutConstraint(item: self,
         attribute: .trailingMargin,
         relatedBy: .equal,
         toItem: superView,
         attribute: .trailingMargin,
         multiplier: 1.0,
         constant: -constraintInset.right)
         
         let verticalConstraintTop = NSLayoutConstraint(item: self,
         attribute: .topMargin,
         relatedBy: .equal,
         toItem: superView,
         attribute: .top,
         multiplier: 1.0,
         constant: constraintInset.top)
         
         let verticalConstraintBottom = NSLayoutConstraint(item: self,
         attribute: .bottomMargin,
         relatedBy: .equal,
         toItem: superView,
         attribute: .bottom,
         multiplier: 1.0,
         constant: constraintInset.bottom)
         
         NSLayoutConstraint.activate([horizonalContraintLeft,
         horizonalContraintRight,
         verticalConstraintTop,
         verticalConstraintBottom])*/
        self.snp.makeConstraints({make in
            make.edges.equalTo(superView).inset(constraintInset)
        })
    }
    
    /** Applies the custom appearance on this UIView */
    open func applyAppearance() -> Void {
        for subview in self.subviews {
            subview.applyAppearance()
        }
    }
}

extension UIViewController {
    /** Sets the NavigationBar Title */
    open func setNavitagionBarTitle(text : String?) {
        self.navigationItem.title = text
    }
    
    /** Sets the NavigationBar Title View */
    open func setNavitagionBarTitle(view : UIView?) {
        self.navigationItem.titleView = view
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
        backButton.title = sharedAppearanceManager.appearance.navigationBarBackButtonTitle
        
        self.navigationItem.backBarButtonItem = backButton
    }
    
    open func applyAppearance() -> Void {
        self.view.applyAppearance()
    }
}

extension UITabBarController {
    override open func applyAppearance() {
        //Updates Navbar Tint Color
        self.tabBar.tintColor = sharedAppearanceManager.appearance.tabBarTintColor
        
        self.tabBar.isTranslucent = sharedAppearanceManager.appearance.tabBarIsTranslucent
        
        if let items = self.tabBar.items {
            for item in items {
                item.setTitleTextAttributes([NSFontAttributeName: sharedAppearanceManager.appearance.tabBarFont], for: .normal)
            }
        }
    }
}

extension UINavigationController {
    override open func applyAppearance() {
        self.navigationBar.isTranslucent = sharedAppearanceManager.appearance.navigationBarIsTranslucent
        
        //Updates Navbar Tint Color
        self.navigationBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        //Updates Navbar Background Color
        self.navigationBar.barTintColor = sharedAppearanceManager.appearance.navigationBarBackgroundColor
        
        //Updates NavigationBar title font
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: sharedAppearanceManager.appearance.navigationBarTitleColor,
            NSFontAttributeName: sharedAppearanceManager.appearance.navigationBarTitleFont
        ]
    }
}
