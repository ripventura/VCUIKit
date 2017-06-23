//
//  VCThemeDefaultStyles.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/17/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

public let CGRectDefault = CGRect(x: 0, y: 0, width: 100, height: 100)

public var sharedStyleManager = VCThemeDefaultStyles()

public class VCThemeDefaultStyles {
    var labelTextColor : UIColor
    var labelFont : UIFont
    
    var buttonTextColor : UIColor
    var buttonFont : UIFont
    
    var tableViewCellTintColor : UIColor
    var tableViewCellBackgroundColor : UIColor
    var tableViewCellTitleTextColor : UIColor
    var tableViewCellTitleFont : UIFont
    var tableViewCellDetailTextColor : UIColor
    var tableViewCellDetailFont : UIFont
    
    var tableViewBackgroundColor : UIColor
    
    var applicationStatusBarStyle : UIStatusBarStyle
    
    var navigationBarTintColor : UIColor
    var navigationBarBackgroundColor : UIColor
    var navigationBarTitleColor : UIColor
    var navigationBarTitleFont : UIFont
    var navigationBarBackButtonTitle : String
    var navigationBarIsTranslucent : Bool
    
    var viewControllerViewTintColor : UIColor
    var viewControllerViewBackgroundColor : UIColor
    
    var tabledViewControllerPlaceholderTextColor : UIColor
    var tabledViewControllerPlaceholderTextFont : UIFont
    var tabledViewControllerPlaceholderTitleColor : UIColor
    var tabledViewControllerPlaceholderTitleFont : UIFont
    
    var tabBarTintColor : UIColor
    var tabBarBackgroundColor : UIColor
    var tabBarFont : UIFont
    var tabBarIsTranslucent : Bool
        
    var bannerSuccessBackgroundColor : UIColor
    var bannerErrorBackgroundColor : UIColor
    var bannerInfoBackgroundColor : UIColor
    var bannerFont : UIFont
    
    var alertTitleColor : UIColor
    var alertTitleFont : UIFont
    var alertMessageColor : UIColor
    var alertMessageFont : UIFont
    var alertViewTintColor : UIColor
    var alertBackgroundColor : UIColor
    var alertCancelButtonColor : UIColor
    var alertCancelButtonTitleColor : UIColor
    var alertCancelButtonTitleFont : UIFont
    var alertButtonColor : UIColor
    var alertButtonTitleColor : UIColor
    var alertButtonTitleFont : UIFont
    var alertCornerRadius : CGFloat
    var alertButtonCornerRadius : CGFloat
    
    var hudMessageColor : UIColor
    var hudTintColor : UIColor
    var hudBackgroundColor : UIColor
    
    init() {
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
