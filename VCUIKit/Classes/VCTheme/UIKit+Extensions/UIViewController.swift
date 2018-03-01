//
//  UIViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 10/11/17.
//

import UIKit

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
        
        // UINavigationBar Items Font
        self.navigationItem.leftBarButtonItems?.forEach({buttonItem in
            if buttonItem.style == .plain {
                if let customFont = sharedAppearanceManager.appearance.navigationBarItemsPlainFont {
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .focused)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .selected)
                }
            }
            else if buttonItem.style == .done {
                if let customFont = sharedAppearanceManager.appearance.navigationBarItemsDoneFont {
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .focused)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .selected)
                }
            }
        })
        self.navigationItem.rightBarButtonItems?.forEach({buttonItem in
            if buttonItem.style == .plain {
                if let customFont = sharedAppearanceManager.appearance.navigationBarItemsPlainFont {
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .focused)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .selected)
                }
            }
            else if buttonItem.style == .done {
                if let customFont = sharedAppearanceManager.appearance.navigationBarItemsDoneFont {
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .focused)
                    buttonItem.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .selected)
                }
            }
        })
        
        // UITabBar Items Font
        if let customFont = sharedAppearanceManager.appearance.tabBarFont {
            if let items = self.tabBarController?.tabBar.items {
                for item in items {
                    item.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
                    item.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .focused)
                    item.setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .selected)
                }
            }
        }
    }
}

extension UITabBarController {
    override open func applyAppearance() {
        //Updates Navbar Tint Color
        self.tabBar.tintColor = sharedAppearanceManager.appearance.tabBarTintColor
        
        self.tabBar.isTranslucent = sharedAppearanceManager.appearance.tabBarIsTranslucent
    }
}

extension UINavigationController {
    override open func applyAppearance() {
        //Updates Navbar Tint Color
        self.navigationBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        //Updates Navbar Background Color
        self.navigationBar.barTintColor = sharedAppearanceManager.appearance.navigationBarBackgroundColor
        
        //Updates NavBar title font
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
