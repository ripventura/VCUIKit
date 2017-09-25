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
    open func addTo(superView: UIView, withConstraint constraintInset: UIEdgeInsets) -> Void {
        
        superView.addSubview(self)

        self.snp.makeConstraints({make in
            make.edges.equalTo(superView).inset(constraintInset)
        })
    }
    
    /** Applies the custom appearance on this UIView */
    @objc open func applyAppearance() -> Void {
        for subview in self.subviews {
            subview.applyAppearance()
        }
    }
    
    // MARK: - Animation
    
    
    /** Shakes the view sideways */
    open func shake(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.x"
        animation.values = [0 * multiplier, 10 * multiplier, -10 * multiplier, 10 * multiplier, -5 * multiplier, 5 * multiplier, -5 * multiplier, 0 * multiplier]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = CFTimeInterval(duration)
        animation.isAdditive = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "shake")
    }
    
    /** Bounces the view vertically */
    open func bounce(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.y"
        animation.values = [
            0 * multiplier,
            -20 * multiplier,
            0 * multiplier,
            -10 * multiplier,
            0 * multiplier,
            -5 * multiplier,
            0 * multiplier]
        animation.keyTimes = [
            0,
            0.4,
            0.6,
            0.8,
            0.9,
            0.95,
            1]
        animation.duration = CFTimeInterval(duration)
        animation.isAdditive = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "bounce")
    }
    
    /** Grows (scales up) the View on both X and Y axis and reverses */
    open func grow(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "transform.scale"
        animation.values = [1, max(1.1, 1.3 * multiplier)]
        animation.keyTimes = [0, 1]
        animation.duration = CFTimeInterval(duration / 2) //.autoreverses doubles the duration time
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "grow")
    }
    
    /** Shrinks (scales down) the View on both X and Y axis and reverses */
    open func shrink(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "transform.scale"
        animation.values = [1, 1 / max(1.1, 1.3 * multiplier)]
        animation.keyTimes = [0, 1]
        animation.duration = CFTimeInterval(duration / 2) //.autoreverses doubles the duration time
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "shrink")
    }
    
    /** Swings the View */
    open func swing(duration: Float = 0.35, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        let rotationAngle: Double = 15.0 * Double(multiplier)
        
        animation.keyPath = "transform.rotation.z"
        animation.values = [
            0,
            rotationAngle / 180 * Double.pi,
            0,
            -rotationAngle / 180 * Double.pi,
            0
        ]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = CFTimeInterval(duration)
        animation.isRemovedOnCompletion = true
        animation.isAdditive = true
        animation.repeatCount = 2
        
        self.layer.add(animation, forKey: "swing")
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
        if let title = sharedAppearanceManager.appearance.navigationBarBackButtonTitle {
            //Updates the BackButton Style
            let backButton = UIBarButtonItem()
            backButton.title = title
            
            self.navigationItem.backBarButtonItem = backButton
        }
    }
    
    @objc open func applyAppearance() -> Void {
        self.view.applyAppearance()
    }
}

extension UITabBarController {
    override open func applyAppearance() {
        //Updates Navbar Tint Color
        self.tabBar.tintColor = sharedAppearanceManager.appearance.tabBarTintColor
        
        self.tabBar.isTranslucent = sharedAppearanceManager.appearance.tabBarIsTranslucent
        
        if let customFont = sharedAppearanceManager.appearance.tabBarFont {
            if let items = self.tabBar.items {
                for item in items {
                    item.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                }
            }
        }
    }
}

extension UINavigationController {
    override open func applyAppearance() {
        //Updates Navbar Tint Color
        self.navigationBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        //Updates Navbar Background Color
        self.navigationBar.barTintColor = sharedAppearanceManager.appearance.navigationBarBackgroundColor
        
        //Updates NavigationBar title font
        var attributes: [NSAttributedStringKey:Any] = [
            NSAttributedStringKey.foregroundColor: sharedAppearanceManager.appearance.navigationBarTitleColor
        ]
        if let customFont = sharedAppearanceManager.appearance.navigationBarTitleFont {
            attributes[NSAttributedStringKey.font] = customFont
        }
        self.navigationBar.titleTextAttributes = attributes
        if #available(iOS 11.0, *) {
            self.navigationBar.largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: sharedAppearanceManager.appearance.navigationBarTitleColor
            ]
        }
    }
}
