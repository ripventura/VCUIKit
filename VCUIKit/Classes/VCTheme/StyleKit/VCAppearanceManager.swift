//
//  VCAppearanceManager.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/17/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

public let CGRectDefault = CGRect(x: 0, y: 0, width: 100, height: 100)

/** Shared Appearance Manager used by UI elements to retrive the app Appearance. */
public var sharedAppearanceManager = VCAppearanceManager()

open class VCAppearanceManager {
    var appearance: VCAppearance
    
    init(appearance: VCAppearance = defaultAppearance) {
        self.appearance = appearance
    }
}

/** Default Appearance used on ViewControllers that don't override any styles.
    Override this with a subclass of VCAppearance to change the default appearance of the app. */
public var defaultAppearance: VCAppearance = VCAppearance()

open class VCAppearance {
    open var labelTextColor : UIColor
    open var labelFont : UIFont
    
    open var buttonTintColor : UIColor = .black
    open var buttonFont : UIFont
    
    open var segmentedControlTintColor : UIColor = .black
    
    open var switchTintColor : UIColor = .black
    
    open var activityIndicatorTintColor : UIColor = .black
    
    open var textFieldTextColor : UIColor
    open var textFieldTextFont : UIFont
    
    open var tableViewCellTintColor : UIColor = .black
    open var tableViewCellBackgroundColor : UIColor
    open var tableViewCellTitleTextColor : UIColor
    open var tableViewCellTitleFont : UIFont
    open var tableViewCellDetailTextColor : UIColor
    open var tableViewCellDetailFont : UIFont
    open var tableViewCellHeight: CGFloat
    
    open var tableViewBackgroundColor : UIColor
    
    open var applicationStatusBarStyle : UIStatusBarStyle
    
    open var navigationBarTintColor : UIColor
    open var navigationBarBackgroundColor : UIColor
    open var navigationBarTitleColor : UIColor
    open var navigationBarTitleFont : UIFont
    open var navigationBarBackButtonTitle : String
    open var navigationBarIsTranslucent : Bool
    
    open var viewControllerViewTintColor : UIColor {
        didSet {
            self.updateTintColors()
        }
    }
    open var viewControllerViewBackgroundColor : UIColor
    
    open var tabledViewControllerPlaceholderTextColor : UIColor
    open var tabledViewControllerPlaceholderTextFont : UIFont
    open var tabledViewControllerPlaceholderTitleColor : UIColor
    open var tabledViewControllerPlaceholderTitleFont : UIFont
    
    open var tabBarTintColor : UIColor = .black
    open var tabBarBackgroundColor : UIColor
    open var tabBarFont : UIFont
    open var tabBarIsTranslucent : Bool
        
    open var bannerSuccessBackgroundColor : UIColor
    open var bannerErrorBackgroundColor : UIColor
    open var bannerInfoBackgroundColor : UIColor
    open var bannerFont : UIFont
    
    open var alertTitleFont : UIFont
    open var alertMessageFont : UIFont
    open var alertCornerRadius : CGFloat
    
    open var hudMessageFont : UIFont
    open var hudRingWidth : CGFloat
    open var hudCornerRadius : CGFloat
    
    public init() {
        // MARK: - VCLabel
        labelTextColor = VCUIKitStyleKit.labelTextColor
        labelFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        
        // MARK: - VCButton
        buttonFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        
        // MARK: - VCTextField
        textFieldTextFont = UIFont.systemFont(ofSize: 14)
        textFieldTextColor = VCUIKitStyleKit.labelTextColor
        
        // MARK: - VCTableViewCell
        tableViewCellBackgroundColor = VCUIKitStyleKit.white
        tableViewCellTitleTextColor = VCUIKitStyleKit.tableViewCellTitleTextColor
        tableViewCellTitleFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        tableViewCellDetailTextColor = VCUIKitStyleKit.tableViewDetailTextColor
        tableViewCellDetailFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        tableViewCellHeight = 60
        
        // MARK: - VCTableView
        tableViewBackgroundColor = VCUIKitStyleKit.tableViewBackgroundColor
        
        // MARK: - UIStatusBar
        applicationStatusBarStyle = UIStatusBarStyle.lightContent
        
        // MARk: - UINavigationBar
        navigationBarTintColor = VCUIKitStyleKit.navigationBarTintColor
        navigationBarBackgroundColor = VCUIKitStyleKit.navigationBarBackgroundColor
        navigationBarTitleColor = VCUIKitStyleKit.white
        navigationBarTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        navigationBarBackButtonTitle = ""
        navigationBarIsTranslucent = false
        
        // MARK: - VCViewController
        viewControllerViewTintColor = VCUIKitStyleKit.viewControllerViewTintColor
        viewControllerViewBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        
        // MARK: - VCTabledViewController
        tabledViewControllerPlaceholderTextColor = VCUIKitStyleKit.labelTextColor
        tabledViewControllerPlaceholderTextFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        tabledViewControllerPlaceholderTitleColor = VCUIKitStyleKit.labelTextColor
        tabledViewControllerPlaceholderTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        // MARK: - UITabBar
        tabBarTintColor = VCUIKitStyleKit.tabBarTintColor
        tabBarBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        tabBarFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        tabBarIsTranslucent = false
        
        // MARK: - VCBannerCreator
        bannerSuccessBackgroundColor = VCUIKitStyleKit.bannerSuccessBackgroundColor
        bannerErrorBackgroundColor = VCUIKitStyleKit.bannerDangerBackgroundColor
        bannerInfoBackgroundColor = VCUIKitStyleKit.bannerInfoBackgroundColor
        bannerFont = UIFont.systemFont(ofSize: 12)
        
        // MARK: - VCAlertView
        alertTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        alertMessageFont = UIFont.systemFont(ofSize: 14)
        alertCornerRadius = 12.0
        
        // MARK: - VCHUD
        hudMessageFont = UIFont.systemFont(ofSize: 14)
        hudRingWidth = 2
        hudCornerRadius = 12
        
        self.updateTintColors()
    }
    
    /** Updates all the TintColor from elements that inherit from the Parent ViewController */
    private func updateTintColors() -> Void {
        buttonTintColor = self.viewControllerViewTintColor
        
        segmentedControlTintColor = self.viewControllerViewTintColor
        
        switchTintColor = self.viewControllerViewTintColor
        
        activityIndicatorTintColor = self.viewControllerViewTintColor
        
        tableViewCellTintColor = self.viewControllerViewTintColor
    }
}
