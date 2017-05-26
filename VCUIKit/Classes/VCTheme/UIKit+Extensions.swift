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
    
    /** Sets a Done Toolbar as InputAccessoryView **/
    func shouldUseDoneToolbar(shouldUse : Bool) {
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
    /** Adds the view to the given superview applying the given constraints insets**/
    func addToSuperViewWithConstraints(viewSuperview : UIView, constraintInset : UIEdgeInsets) {
        self.addToSuperView(viewSuperview: viewSuperview)
        
        self.snp.makeConstraints({ make in
            make.edges.equalTo(self.superview!).inset(constraintInset)
        })
    }
    
    /** Adds the view to the given superview **/
    func addToSuperView(viewSuperview : UIView) {
        viewSuperview.addSubview(self)
    }
}

extension UIViewController {
    
    /** Sets the NavigationBar Title **/
    func setNavitagionBarTitle(title : String) {
        self.navigationItem.title = title
    }
    
    /** Adds a UIBarButtomItem to the RightItems on the NavigationBar **/
    func addButtomItemToNavigationBarRightItems(buttomItem : UIBarButtonItem) {
        var array = self.navigationItem.rightBarButtonItems
        if array == nil {
            array = []
        }
        array?.append(buttomItem)
        self.navigationItem.rightBarButtonItems = array
    }
    
    /** Adds a UIBarButtomItem to the LeftItems on the NavigationBar **/
    func addButtomItemToNavigationBarLeftItems(buttomItem : UIBarButtonItem) {
        var array = self.navigationItem.leftBarButtonItems
        if array == nil {
            array = []
        }
        array?.append(buttomItem)
        self.navigationItem.leftBarButtonItems = array
    }
    
    /** Gets the first ViewController on the NavigationController stack **/
    func getNavigationControllerFirstController() -> UIViewController? {
        return self.navigationController!.viewControllers.first
    }
    
    /** Gets the last ViewController on the NavigationController stack (does not include the current visible ViewController) **/
    func getNavigationControllerLastController() -> UIViewController? {
        return self.navigationController!.viewControllers.last
    }
    
    /** Resigns all views firstResponder **/
    func resignViewsFirstResponder() {
        self.view.endEditing(true)
    }
    
    
    internal func updateBackButtonStyle() {
        //Updates the BackButton Style
        let backButton = UIBarButtonItem()
        backButton.title = sharedStyleManager.navigationBarBackButtonTitle
        
        self.navigationItem.backBarButtonItem = backButton
    }
}

/** Extends the UITabBarController to apply the desired Theme to its contents **/
extension UITabBarController {
    
    func applyTabBarThemeStyle() {
        //Updates Navbar Tint Color
        self.tabBar.tintColor = sharedStyleManager.tabBarTintColor
        
        //Solid background
        self.tabBar.isTranslucent = false
    }
    
    /** This let's the Visible ViewController decide the supportedInterfaceOrientations **/
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if let selected = selectedViewController {
            if  selected as? VCViewController != nil {
                
                return selected.supportedInterfaceOrientations
            }
        }
        return sharedStyleManager.defaultInterfaceOrientation
    }
    
    /** This let's the Visible ViewController decide if the app shouldRotate **/
    override open var shouldAutorotate: Bool {
        if let selected = selectedViewController {
            if  selected as? VCViewController != nil {
                
                return selected.shouldAutorotate
            }
        }
        return super.shouldAutorotate
    }
}

/** Extends the UINavigationController to apply the desired Theme to its contents **/
extension UINavigationController {
    
    func applyNavigationThemeStyle() {
        //Solid background
        self.navigationBar.isTranslucent = false
        
        //Updates Navbar Tint Color
        self.navigationBar.tintColor = sharedStyleManager.navigationBarTintColor
        
        //Updates Navbar Background Color
        self.navigationBar.barTintColor = sharedStyleManager.navigationBarBackgroundColor
        
        //Updates NavigationBar title font
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: sharedStyleManager.navigationBarTitleColor]
    }
    
    /** This let's the Visible ViewController decide the supportedInterfaceOrientations **/
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if self.visibleViewController != nil && self.visibleViewController as? VCViewController != nil {
            return self.visibleViewController!.supportedInterfaceOrientations
        }
        return sharedStyleManager.defaultInterfaceOrientation
    }
    
    /** This let's the Visible ViewController decide if the app shouldRotate **/
    override open var shouldAutorotate: Bool {
        if self.visibleViewController != nil && self.visibleViewController as? VCViewController != nil  {
            return self.visibleViewController!.shouldAutorotate
        }
        return super.shouldAutorotate
    }
}
