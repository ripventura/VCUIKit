//
//  VCAppearanceManager.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/17/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import SwiftMessages

public let CGRectDefault = CGRect(x: 0, y: 0, width: 100, height: 100)

/** Shared Appearance Manager used by UI elements to retrive the app Appearance. */
public var sharedAppearanceManager = VCAppearanceManager()

open class VCAppearanceManager {
    open var appearance: VCAppearance
    /** Initialize the defaultAppearance inside the "code" block under AppDelegate */
    open var initializeDefaultAppearance: (() -> Void)?
    
    public init(appearance: VCAppearance = defaultAppearance) {
        self.appearance = appearance
    }
}

/** Default Appearance used on ViewControllers that don't override any styles.
 Override this with a subclass of VCAppearance to change the default appearance of the app. */
public var defaultAppearance: VCAppearance = VCAppearance()

open class VCAppearance {
    open var labelTextColor : UIColor
    open var labelFont : UIFont?
    
    open var buttonTintColor : UIColor = .black
    open var buttonFont : UIFont?
    
    open var segmentedControlTintColor : UIColor = .black
    open var segmentedControlTitleFont : UIFont?
    
    open var progressViewTrackTintColor : UIColor = .lightGray
    open var progressViewProgressTintColor : UIColor = .black
    
    open var switchTintColor : UIColor = .black
    
    open var toolbarTintColor : UIColor = .black
    
    open var activityIndicatorTintColor : UIColor = .black
    
    open var textFieldTextColor : UIColor
    open var textFieldTextFont : UIFont?
    
    open var tableViewCellTintColor : UIColor = .black
    open var tableViewCellBackgroundColor : UIColor
    open var tableViewCellTitleTextColor : UIColor
    open var tableViewCellTitleFont : UIFont?
    open var tableViewCellDetailTextColor : UIColor
    open var tableViewCellDetailFont : UIFont?
    open var tableViewCellEstimatedHeight: CGFloat
    
    open var tableViewBackgroundColor : UIColor
    open var tableViewSeparatorColor : UIColor
    
    open var collectionViewCellTintColor : UIColor = .black
    open var collectionViewCellBackgroundColor : UIColor
    
    open var collectionViewBackgroundColor : UIColor
    
    open var applicationStatusBarStyle : UIStatusBarStyle
    
    open var navigationBarTintColor : UIColor
    open var navigationBarBackgroundColor : UIColor
    open var navigationBarTitleColor : UIColor
    open var navigationBarTitleFont : UIFont?
    open var navigationBarBackButtonTitle : String?
    open var navigationBarItemsPlainFont : UIFont?
    open var navigationBarItemsDoneFont : UIFont?
    
    open var viewControllerViewTintColor : UIColor {
        didSet {
            self.updateTintColors()
        }
    }
    open var viewControllerViewBackgroundColor : UIColor
    
    open var placeholderViewTextColor : UIColor
    open var placeholderViewTextFont : UIFont
    open var placeholderViewTitleColor : UIColor
    open var placeholderViewTitleFont : UIFont
    open var placeholderViewImageSize : CGSize
    open var placeholderViewButtonTintColor : UIColor = .black
    open var placeholderViewButtonFont : UIFont
    
    open var tabBarTintColor : UIColor = .black
    open var tabBarBackgroundColor : UIColor
    open var tabBarFont : UIFont?
    open var tabBarIsTranslucent : Bool
    
    open var bannerSuccessBackgroundColor : UIColor
    open var bannerErrorBackgroundColor : UIColor
    open var bannerInfoBackgroundColor : UIColor
    open var bannerWarningBackgroundColor : UIColor
    open var bannerSuccessTextColor : UIColor
    open var bannerErrorTextColor : UIColor
    open var bannerInfoTextColor : UIColor
    open var bannerWarningTextColor : UIColor
    open var bannerMessageFont : UIFont
    open var bannerTitleFont : UIFont
    open var bannerIconSize : CGSize
    open var bannerDuration: TimeInterval
    open var bannerDismissesOnTap: Bool
    open var bannerDropShadow: Bool
    open var bannerDimMode: SwiftMessages.DimMode
    open var bannerPresentationContext: SwiftMessages.PresentationContext
    open var bannerPresentationDirection: SwiftMessages.PresentationStyle
    
    open var alertTitleFont : UIFont
    open var alertMessageFont : UIFont
    open var alertCornerRadius : CGFloat
    
    open var hudMessageFont : UIFont
    open var hudRingWidth : CGFloat
    open var hudCornerRadius : CGFloat
    
    public init() {
        // MARK: - VCLabel
        labelTextColor = VCUIKitStyleKit.labelTextColor
        
        // MARK: - VCTextField
        textFieldTextColor = VCUIKitStyleKit.labelTextColor
        
        // MARK: - VCTableViewCell
        tableViewCellBackgroundColor = VCUIKitStyleKit.white
        tableViewCellTitleTextColor = VCUIKitStyleKit.tableViewCellTitleTextColor
        tableViewCellDetailTextColor = VCUIKitStyleKit.tableViewDetailTextColor
        tableViewCellEstimatedHeight = 44
        
        // MARK: - VCTableView
        tableViewBackgroundColor = VCUIKitStyleKit.tableViewBackgroundColor
        tableViewSeparatorColor = VCUIKitStyleKit.tableViewDetailTextColor
        
        // MARK: - VCCollectionViewCell
        collectionViewCellBackgroundColor = VCUIKitStyleKit.white
        
        // MARK: - VCCollectionView
        collectionViewBackgroundColor = VCUIKitStyleKit.tableViewBackgroundColor
        
        // MARK: - UIStatusBar
        applicationStatusBarStyle = UIStatusBarStyle.lightContent
        
        // MARK: - UINavigationBar
        navigationBarTintColor = VCUIKitStyleKit.navigationBarTintColor
        navigationBarBackgroundColor = VCUIKitStyleKit.navigationBarBackgroundColor
        navigationBarTitleColor = VCUIKitStyleKit.white
        navigationBarBackButtonTitle = ""
        
        // MARK: - VCViewController
        viewControllerViewTintColor = VCUIKitStyleKit.viewControllerViewTintColor
        viewControllerViewBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        
        // MARK: - VCPlaceholderView
        placeholderViewTextColor = VCUIKitStyleKit.labelTextColor
        placeholderViewTextFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        placeholderViewTitleColor = VCUIKitStyleKit.labelTextColor
        placeholderViewTitleFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        placeholderViewImageSize = CGSize(width: 100.0, height: 100.0)
        placeholderViewButtonTintColor = VCUIKitStyleKit.viewControllerViewTintColor
        placeholderViewButtonFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        // MARK: - UITabBar
        tabBarTintColor = VCUIKitStyleKit.tabBarTintColor
        tabBarBackgroundColor = VCUIKitStyleKit.viewControllerViewBackgroundColor
        tabBarIsTranslucent = false
        
        // MARK: - VCBannerCreator
        bannerSuccessBackgroundColor = VCUIKitStyleKit.bannerSuccessBackgroundColor
        bannerErrorBackgroundColor = VCUIKitStyleKit.bannerDangerBackgroundColor
        bannerInfoBackgroundColor = VCUIKitStyleKit.bannerInfoBackgroundColor
        bannerWarningBackgroundColor = UIColor.orange
        bannerSuccessTextColor = UIColor.white
        bannerErrorTextColor = UIColor.white
        bannerInfoTextColor = UIColor.darkText
        bannerWarningTextColor = UIColor.white
        bannerMessageFont = UIFont.systemFont(ofSize: 12)
        bannerTitleFont = UIFont.boldSystemFont(ofSize: 14)
        bannerIconSize = CGSize(width: 20.0, height: 20.0)
        bannerDuration = 3
        bannerDismissesOnTap = true
        bannerDropShadow = true
        bannerDimMode = .none
        bannerPresentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        bannerPresentationDirection = .top
        
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
        
        collectionViewCellTintColor = self.viewControllerViewTintColor
        
        toolbarTintColor = self.viewControllerViewTintColor
        
        progressViewProgressTintColor = self.viewControllerViewTintColor
        
        placeholderViewButtonTintColor = self.viewControllerViewTintColor
    }
}

