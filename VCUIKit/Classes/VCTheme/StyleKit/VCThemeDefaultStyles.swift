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
    var defaultInterfaceOrientation : UIInterfaceOrientationMask
    
    var applicationStatusBarStyle : UIStatusBarStyle = UIStatusBarStyle.lightContent
    
    /** Affects UIBarButtonItems **/
    var navigationBarTintColor : UIColor
    var navigationBarBackgroundColor : UIColor
    var navigationBarTitleColor : UIColor
    var navigationBarBackButtonTitle : String
    
    var viewControllerViewTintColor : UIColor
    var viewControllerViewBackgroundColor : UIColor
    
    var iconButtonFillColor : UIColor
    
    var flatButtonBackgroundColor : UIColor
    var flatButtonShadowColor : UIColor
    var flatButtonNormalTitleColor : UIColor
    var flatButtonPressedTitleColor : UIColor
    var flatButtonShadowHeight : CGFloat
    var flatButtonCornerRadius : CGFloat
    
    var labelTextColor : UIColor
    var labelBackgroundColor : UIColor
    
    var tableViewBackgroundColor : UIColor
    
    var detailSubtitleTableViewCellSubtitleTextColor : UIColor
    
    var checkNoteTableViewCellCheckedHeight : CGFloat
    var checkNoteTableViewCellUncheckedHeight : CGFloat
    
    var tableViewCellTintColor : UIColor
    var tableViewCellBackgroundColor : UIColor
    var tableViewCellTitleTextColor : UIColor
    var tableViewCellDetailTextColor : UIColor
    var tableViewCellHeight : CGFloat
    
    var signatureViewBackgroundColor : UIColor
    var signatureViewStrokeColor : UIColor
    
    var bannerSuccessBackgroundColor : UIColor
    var bannerErrorBackgroundColor : UIColor
    var bannerInfoBackgroundColor : UIColor
    
    var alertTitleColor : UIColor
    var alertMessageColor : UIColor
    var alertViewTintColor : UIColor
    var alertBackgroundColor : UIColor
    var alertCancelButtonColor : UIColor
    var alertCancelButtonTitleColor : UIColor
    var alertButtonColor : UIColor
    var alertButtonTitleColor : UIColor
    var alertCornerRadius : CGFloat
    var alertButtonCornerRadius : CGFloat
    
    var tabBarTintColor : UIColor
    
    var hudMessageColor : UIColor
    var hudTintColor : UIColor
    var hudBackgroundColor : UIColor
    
    init() {
        defaultInterfaceOrientation = .allButUpsideDown
        
        /** Requires UIViewControllerBasedStatusBarAppearance: NO on Info.plist **/
        applicationStatusBarStyle = UIStatusBarStyle.lightContent
        
        /** Affects UIBarButtonItems **/
        navigationBarTintColor = VCUIKitStyleKit.navigationBarTintColor
        navigationBarBackgroundColor = VCUIKitStyleKit.navigationBarBackgroundColor
        navigationBarTitleColor = VCUIKitStyleKit.white
        navigationBarBackButtonTitle = ""
        
        viewControllerViewTintColor = VCUIKitStyleKit.viewControllerViewTintColor
        viewControllerViewBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        
        iconButtonFillColor = VCUIKitStyleKit.vCIconButtonFillColor
        
        flatButtonBackgroundColor = VCUIKitStyleKit.vCFlatUIButtonBackgroundColor
        flatButtonShadowColor = VCUIKitStyleKit.vCFlatUIButtonShadowColor
        flatButtonNormalTitleColor = VCUIKitStyleKit.vCFlatUIButtonNormalTitleColor
        flatButtonPressedTitleColor = VCUIKitStyleKit.vCFlatUIButtonPressedTitleColor
        flatButtonShadowHeight = 3.0
        flatButtonCornerRadius = 6.0
        
        labelTextColor = VCUIKitStyleKit.labelTextColor
        labelBackgroundColor = VCUIKitStyleKit.labelBackgroundColor
        
        tableViewBackgroundColor = VCUIKitStyleKit.tableViewBackgroundColor
        
        detailSubtitleTableViewCellSubtitleTextColor = VCUIKitStyleKit.tableViewDetailTextColor
        
        checkNoteTableViewCellCheckedHeight = 140
        checkNoteTableViewCellUncheckedHeight = 60
        
        tableViewCellTintColor = VCUIKitStyleKit.tableViewCellTintColor
        tableViewCellBackgroundColor = VCUIKitStyleKit.white
        tableViewCellTitleTextColor = VCUIKitStyleKit.tableViewCellTitleTextColor
        tableViewCellDetailTextColor = VCUIKitStyleKit.tableViewDetailTextColor
        tableViewCellHeight = 60
        
        signatureViewBackgroundColor = VCUIKitStyleKit.signaturePickerViewControllerViewBackgroundColor
        signatureViewStrokeColor = VCUIKitStyleKit.signaturePickerViewControllerStrokeColor
        
        bannerSuccessBackgroundColor = VCUIKitStyleKit.bannerSuccessBackgroundColor
        bannerErrorBackgroundColor = VCUIKitStyleKit.bannerDangerBackgroundColor
        bannerInfoBackgroundColor = VCUIKitStyleKit.bannerInfoBackgroundColor
        
        alertTitleColor = VCUIKitStyleKit.alertTitleTextColor
        alertMessageColor = VCUIKitStyleKit.alertMessageTextColor
        alertViewTintColor = VCUIKitStyleKit.alertViewTintColor
        alertBackgroundColor = VCUIKitStyleKit.alertBackgroundColor
        alertCancelButtonColor = VCUIKitStyleKit.alertCancelButtonBackgroundColor
        alertCancelButtonTitleColor = VCUIKitStyleKit.alertCancelButtonTitleColor
        alertButtonColor = VCUIKitStyleKit.alertCancelButtonBackgroundColor
        alertButtonTitleColor = VCUIKitStyleKit.alertCancelButtonTitleColor
        alertCornerRadius = 16.0
        alertButtonCornerRadius = 16.0
        
        tabBarTintColor = VCUIKitStyleKit.tabBarTintColor
        
        hudMessageColor = VCUIKitStyleKit.hUDMessageTextColor
        hudTintColor = VCUIKitStyleKit.hUDTintColor
        hudBackgroundColor = VCUIKitStyleKit.hUDBackgroundColor
    }
}
