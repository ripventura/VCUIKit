//
//  VCBannerCreator.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/18/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import SwiftMessages

public let sharedBannerCreator : VCBannerCreator = VCBannerCreator()


open class VCBannerCreator {
    
    var bannerMessager : SwiftMessages
    
    enum DefaultErrorMessage: String {
        case IncorrectInput = "The information provided is incorrect. Please try again."
    }
    
    init() {
        bannerMessager = SwiftMessages()
        bannerMessager.pauseBetweenMessages = 2
    }
    
    /**
     * Shows a Banner with the given parameters
     *
     * Theme: Success, Info, Error
     * Message: Message being displayed
     * Title: Title being displayed
     * IconImage: Custom image to be used as Icon on the left
     * Duration: Duration to display de Banner. 0 means forever
     * DismissesOnTap: Wheter the banner hides on tap / pan gesture
     * DropShadow: Wheter the banner should have a shadow along it's borders
     * WindowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade)
     * PresentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar)
     * PresentationDirection: Where the Banner should appear. Top, Bottom.
     */
    public func showBannerWithTheme(theme : Theme,
                             message : String,
                             title : String? = nil,
                             iconImage : UIImage? = nil,
                             duration : TimeInterval = 3,
                             dismissesOnTap : Bool = true,
                             dropShadow : Bool = true,
                             windowDimMode : SwiftMessages.DimMode = .none,
                             presentationContext : SwiftMessages.PresentationContext = .window(windowLevel: UIWindowLevelStatusBar),
                             presentationDirection : SwiftMessages.PresentationStyle = .top) {
        
        var config = SwiftMessages.Config()
        // Slide up from the top
        config.presentationStyle = presentationDirection
        
        // Display in a window at the specified window level: UIWindowLevelStatusBar
        // displays over the status bar while UIWindowLevelNormal displays under.
        config.presentationContext = presentationContext
        
        // Default auto-hiding behavior.
        if duration > 0 {
            config.duration = .seconds(seconds: duration)
        }
        else {
            config.duration = .forever
        }
        
        // Dim the background like a popover view. Can also hide when the background is tapped.
        config.dimMode = windowDimMode
        
        // Eisable the interactive pan-to-hide gesture.
        config.interactiveHide = dismissesOnTap
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .lightContent
        
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .MessageView)
        
        // Theme message elements with the desired style.
        view.configureTheme(theme)
        
        
        if dropShadow {
            // Drops a Shadow outside the banner frame
            view.configureDropShadow()
        }
        
        // Configures the message background color and content
        if theme == .success {
            //view.configureTheme(backgroundColor: sharedAppearanceManager.bannerSuccessBackgroundColor, foregroundColor: UIColor.whiteColor())
            view.configureContent(title: title != nil ? title! : "Success", body: message)
        }
        else if theme == .error {
            //view.configureTheme(backgroundColor: sharedAppearanceManager.bannerErrorBackgroundColor, foregroundColor: UIColor.whiteColor())
            view.configureContent(title: title != nil ? title! : "Error", body: message)
        }
        else if theme == .info {
            //view.configureTheme(backgroundColor: sharedAppearanceManager.bannerInfoBackgroundColor, foregroundColor: UIColor.whiteColor())
            view.configureContent(title: title != nil ? title! : "Info", body: message)
        }
        
        // Hides the Button
        view.button?.isHidden = true
        
        DispatchQueue.main.async {
            // Show the banner
            self.bannerMessager.show(config: config, view: view)
        }
    }
    
    /**
     * Shows a StatusBar Message with the given parameters
     *
     * Theme: Success, Info, Error, Nil (uses default NavigationBar styles)
     * Message: Message being displayed
     * Duration: Duration to display de Banner. 0 means forever
     * Tallbar: Wheter the "banner" should cover double the StatusBar height
     */
    public func showStatusBarMessage(theme : Theme? = nil,
                              message : String,
                              duration : TimeInterval = 3,
                              tallBar : Bool = false) {
        
        var config = SwiftMessages.Config()
        
        // Display in a window at the specified window level: UIWindowLevelStatusBar
        // displays over the status bar while UIWindowLevelNormal displays under.
        config.presentationContext = tallBar ? .window(windowLevel: UIWindowLevelNormal) : .window(windowLevel: UIWindowLevelStatusBar)
        
        // Default auto-hiding behavior.
        if duration > 0 {
            config.duration = .seconds(seconds: duration)
        }
        else {
            config.duration = .forever
        }
        
        // Dim the background like a popover view. Can also hide when the background is tapped.
        config.dimMode = .none
        
        // Eisable the interactive pan-to-hide gesture.
        config.interactiveHide = false
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = sharedAppearanceManager.applicationStatusBarStyle
        
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .StatusLine)
        
        // Configures the message content
        view.configureContent(body: message)
        
        if theme == nil {
            view.backgroundView.backgroundColor = sharedAppearanceManager.navigationBarBackgroundColor
            view.bodyLabel?.textColor = sharedAppearanceManager.navigationBarTintColor
        } else {
            // Theme message elements with the desired style.
            view.configureTheme(theme!)
        }
        
        DispatchQueue.main.async {
            // Show the banner
            self.bannerMessager.show(config: config, view: view)
        }
    }
    
    
    /**
     * Shows a Banner with the given parameters
     *
     * ContentView: Custom UIView to be displayed inside the Banner
     * Duration: Duration to display de Banner. 0 means forever
     * DismissesOnTap: Wheter the banner hides on tap / pan gesture
     * DropShadow: Wheter the banner should have a shadow along it's borders
     * WindowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade)
     * PresentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar)
     * PresentationDirection: Where the Banner should appear. Top, Bottom.
     */
    public func showCustomBanner(contentView : UIView,
                          duration : TimeInterval = 0,
                          dismissesOnTap : Bool = true,
                          dropShadow : Bool = true,
                          windowDimMode : SwiftMessages.DimMode = .gray(interactive: false),
                          presentationContext : SwiftMessages.PresentationContext = .window(windowLevel: UIWindowLevelStatusBar),
                          presentationDirection : SwiftMessages.PresentationStyle = .top) {
        
        
        var config = SwiftMessages.Config()
        // Slide up from the top
        config.presentationStyle = presentationDirection
        
        // Display in a window at the specified window level: UIWindowLevelStatusBar
        // displays over the status bar while UIWindowLevelNormal displays under.
        config.presentationContext = presentationContext
        
        // Default auto-hiding behavior.
        if duration > 0 {
            config.duration = .seconds(seconds: duration)
        }
        else {
            config.duration = .forever
        }
        
        // Dim the background like a popover view. Can also hide when the background is tapped.
        config.dimMode = windowDimMode
        
        // Eisable the interactive pan-to-hide gesture.
        config.interactiveHide = dismissesOnTap
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .lightContent
        
        
        let view = BaseView(frame: CGRectDefault)
        view.installContentView(contentView)
        view.preferredHeight = contentView.frame.size.height
        
        if dropShadow {
            // Drops a Shadow outside the banner frame
            view.configureDropShadow()
        }
        
        DispatchQueue.main.async {
            // Show the banner
            self.bannerMessager.show(config: config, view: view)
        }
    }
    
    /** Hides all banners **/
    public func hideBanners() {
        DispatchQueue.main.async {
            self.bannerMessager.hide()
        }
    }
}
