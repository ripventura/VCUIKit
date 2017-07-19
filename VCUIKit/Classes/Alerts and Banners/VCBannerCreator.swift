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
     Shows a Banner.
     
     - Parameters:
        - theme: Success, Info, Error.
        - message: Message being displayed.
        - title: Title being displayed.
        - icon: Custom image to be used as Icon on the left.
        - duration: Duration to display de Banner. 0 means forever.
        - dismissesOnTap: Wheter the banner hides on tap / pan gesture.
        - dropShadow: Wheter the banner should have a shadow along it's borders.
        - windowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade).
        - presentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar).
        - presentationDirection: Where the Banner should appear. Top, Bottom.
    */
    public func showBanner(theme : Theme,
                           message : String,
                           title : String? = nil,
                           icon : UIImage? = nil,
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
            //view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerSuccessBackgroundColor, foregroundColor: UIColor.whiteColor())
            view.configureContent(title: title != nil ? title! : "Success", body: message)
        }
        else if theme == .error {
            //view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerErrorBackgroundColor, foregroundColor: UIColor.whiteColor())
            view.configureContent(title: title != nil ? title! : "Error", body: message)
        }
        else if theme == .info {
            //view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerInfoBackgroundColor, foregroundColor: UIColor.whiteColor())
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
     Shows a StatusBar Message.
     
     - Parameters:
        - theme: Success, Info, Error.
        - message: Message being displayed.
        - duration: Duration to display de Banner. 0 means forever.
        - tallbar: Wheter the "banner" should cover double the StatusBar height
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
        config.preferredStatusBarStyle = sharedAppearanceManager.appearance.applicationStatusBarStyle
        
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .StatusLine)
        
        // Configures the message content
        view.configureContent(body: message)
        
        if theme == nil {
            view.backgroundView.backgroundColor = sharedAppearanceManager.appearance.navigationBarBackgroundColor
            view.bodyLabel?.textColor = sharedAppearanceManager.appearance.navigationBarTintColor
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
     Shows a Custom Banner.
     
     - Parameters:
        - contentView: Custom UIView to be displayed inside the Banner.
        - duration: Duration to display de Banner. 0 means forever.
        - dismissesOnTap: Wheter the banner hides on tap / pan gesture.
        - dropShadow: Wheter the banner should have a shadow along it's borders.
        - windowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade).
        - presentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar).
        - presentationDirection: Where the Banner should appear. Top, Bottom.
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
