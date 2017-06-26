//
//  VCAppearanceManager.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/17/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

public let CGRectDefault = CGRect(x: 0, y: 0, width: 100, height: 100)

public var sharedAppearanceManager = VCAppearanceManager()

open class VCAppearanceManager {
    open var labelTextColor : UIColor
    open var labelFont : UIFont
    
    open var buttonTextColor : UIColor
    open var buttonFont : UIFont
    
    open var tableViewCellTintColor : UIColor
    open var tableViewCellBackgroundColor : UIColor
    open var tableViewCellTitleTextColor : UIColor
    open var tableViewCellTitleFont : UIFont
    open var tableViewCellDetailTextColor : UIColor
    open var tableViewCellDetailFont : UIFont
    
    open var tableViewBackgroundColor : UIColor
    
    open var applicationStatusBarStyle : UIStatusBarStyle
    
    open var navigationBarTintColor : UIColor
    open var navigationBarBackgroundColor : UIColor
    open var navigationBarTitleColor : UIColor
    open var navigationBarTitleFont : UIFont
    open var navigationBarBackButtonTitle : String
    open var navigationBarIsTranslucent : Bool
    
    open var viewControllerViewTintColor : UIColor
    open var viewControllerViewBackgroundColor : UIColor
    
    open var tabledViewControllerPlaceholderTextColor : UIColor
    open var tabledViewControllerPlaceholderTextFont : UIFont
    open var tabledViewControllerPlaceholderTitleColor : UIColor
    open var tabledViewControllerPlaceholderTitleFont : UIFont
    
    open var tabBarTintColor : UIColor
    open var tabBarBackgroundColor : UIColor
    open var tabBarFont : UIFont
    open var tabBarIsTranslucent : Bool
        
    open var bannerSuccessBackgroundColor : UIColor
    open var bannerErrorBackgroundColor : UIColor
    open var bannerInfoBackgroundColor : UIColor
    open var bannerFont : UIFont
    
    open var alertTitleColor : UIColor
    open var alertTitleFont : UIFont
    open var alertMessageColor : UIColor
    open var alertMessageFont : UIFont
    open var alertViewTintColor : UIColor
    open var alertBackgroundColor : UIColor
    open var alertCancelButtonColor : UIColor
    open var alertCancelButtonTitleColor : UIColor
    open var alertCancelButtonTitleFont : UIFont
    open var alertButtonColor : UIColor
    open var alertButtonTitleColor : UIColor
    open var alertButtonTitleFont : UIFont
    open var alertCornerRadius : CGFloat
    open var alertButtonCornerRadius : CGFloat
    
    open var hudMessageColor : UIColor
    open var hudTintColor : UIColor
    open var hudBackgroundColor : UIColor
    
    public init() {
        // MARK: - VCLabel
        labelTextColor = VCUIKitStyleKit.labelTextColor
        labelFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        
        // MARK: - VCButton
        buttonTextColor = VCUIKitStyleKit.viewControllerViewTintColor
        buttonFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        
        // MARK: - VCTableViewCell
        tableViewCellTintColor = VCUIKitStyleKit.tableViewCellTintColor
        tableViewCellBackgroundColor = VCUIKitStyleKit.white
        tableViewCellTitleTextColor = VCUIKitStyleKit.tableViewCellTitleTextColor
        tableViewCellTitleFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        tableViewCellDetailTextColor = VCUIKitStyleKit.tableViewDetailTextColor
        tableViewCellDetailFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // MARK: - VCTableView
        tableViewBackgroundColor = VCUIKitStyleKit.tableViewBackgroundColor
        
        // MARK: - Controller
        applicationStatusBarStyle = UIStatusBarStyle.lightContent
        
        //Affects UIBarButtonItems
        navigationBarTintColor = VCUIKitStyleKit.navigationBarTintColor
        navigationBarBackgroundColor = VCUIKitStyleKit.navigationBarBackgroundColor
        navigationBarTitleColor = VCUIKitStyleKit.white
        navigationBarTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        navigationBarBackButtonTitle = ""
        navigationBarIsTranslucent = false
        
        viewControllerViewTintColor = VCUIKitStyleKit.viewControllerViewTintColor
        viewControllerViewBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        
        tabledViewControllerPlaceholderTextColor = VCUIKitStyleKit.labelTextColor
        tabledViewControllerPlaceholderTextFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        tabledViewControllerPlaceholderTitleColor = VCUIKitStyleKit.labelTextColor
        tabledViewControllerPlaceholderTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        tabBarTintColor = VCUIKitStyleKit.tabBarTintColor
        tabBarBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        tabBarFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        tabBarIsTranslucent = false
        
        // MARK: - Banner
        bannerSuccessBackgroundColor = VCUIKitStyleKit.bannerSuccessBackgroundColor
        bannerErrorBackgroundColor = VCUIKitStyleKit.bannerDangerBackgroundColor
        bannerInfoBackgroundColor = VCUIKitStyleKit.bannerInfoBackgroundColor
        bannerFont = UIFont.systemFont(ofSize: 12)
        
        alertTitleColor = VCUIKitStyleKit.alertTitleTextColor
        alertTitleFont = UIFont.systemFont(ofSize: 14)
        alertMessageColor = VCUIKitStyleKit.alertMessageTextColor
        alertMessageFont = UIFont.systemFont(ofSize: 12)
        alertViewTintColor = VCUIKitStyleKit.alertViewTintColor
        alertBackgroundColor = VCUIKitStyleKit.alertBackgroundColor
        alertCancelButtonColor = VCUIKitStyleKit.alertCancelButtonBackgroundColor
        alertCancelButtonTitleColor = VCUIKitStyleKit.alertCancelButtonTitleColor
        alertCancelButtonTitleFont = UIFont.systemFont(ofSize: 12)
        alertButtonColor = VCUIKitStyleKit.alertCancelButtonBackgroundColor
        alertButtonTitleColor = VCUIKitStyleKit.alertCancelButtonTitleColor
        alertButtonTitleFont = UIFont.systemFont(ofSize: 12)
        alertCornerRadius = 16.0
        alertButtonCornerRadius = 16.0
        
        hudMessageColor = VCUIKitStyleKit.hUDMessageTextColor
        hudTintColor = VCUIKitStyleKit.hUDTintColor
        hudBackgroundColor = VCUIKitStyleKit.hUDBackgroundColor
    }
}
