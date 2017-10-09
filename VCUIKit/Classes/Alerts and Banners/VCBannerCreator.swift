//
//  VCBannerCreator.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/18/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import SwiftMessages
import VCSwiftToolkit

public let sharedBannerCreator : VCBannerCreator = VCBannerCreator()

open class VCBannerCreator {
    
    var bannerMessager : SwiftMessages
    
    init() {
        bannerMessager = SwiftMessages()
        bannerMessager.pauseBetweenMessages = 0.5
    }
    
    /**
     Shows a Banner.
     
     - Parameters:
     - theme: Success, Info, Error.
     - message: Message being displayed.
     - title: Title being displayed.
     - icon: Custom image to be used as Icon on the left.
     - duration: Duration to display de Banner. 0 means forever.
     - dismissesOnTap: Whether the banner hides on tap / pan gesture.
     - dropShadow: Whether the banner should have a shadow along it's borders.
     - windowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade).
     - presentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar).
     - presentationDirection: Where the Banner should appear. Top, Bottom.
     */
    public func showBanner(theme: Theme,
                           message: String,
                           title: String? = nil,
                           icon: UIImage? = nil,
                           duration: TimeInterval? = nil,
                           dismissesOnTap: Bool? = nil,
                           dropShadow: Bool? = nil,
                           windowDimMode: SwiftMessages.DimMode? = nil,
                           presentationContext: SwiftMessages.PresentationContext? = nil,
                           presentationDirection: SwiftMessages.PresentationStyle? = nil) {
        
        let config = self.defaultConfig(duration: duration,
                                        dismissesOnTap: dismissesOnTap,
                                        dropShadow: dropShadow,
                                        windowDimMode: windowDimMode,
                                        presentationContext: presentationContext,
                                        presentationDirection: presentationDirection)
        
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .messageView)
        
        // Theme message elements with the desired style.
        view.configureTheme(theme)
        
        // Sets the font
        view.titleLabel?.font = sharedAppearanceManager.appearance.bannerTitleFont
        view.bodyLabel?.font = sharedAppearanceManager.appearance.bannerMessageFont
        
        let dropShadow = dropShadow ?? sharedAppearanceManager.appearance.bannerDropShadow
        if dropShadow {
            // Drops a Shadow outside the banner frame
            view.configureDropShadow()
        }
        
        let iconSize = sharedAppearanceManager.appearance.bannerIconSize
        
        // Configures the message background color and content
        if theme == .success {
            view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerSuccessBackgroundColor,
                                foregroundColor: sharedAppearanceManager.appearance.bannerSuccessTextColor)
            if let icon = icon {
                view.configureContent(title: title ?? "Success", body: message, iconImage: icon.vcScaleToNewSize(newSize: iconSize))
            }
            else {
                view.configureContent(title: title ?? "Success", body: message)
            }
        }
        else if theme == .error {
            view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerErrorBackgroundColor,
                                foregroundColor: sharedAppearanceManager.appearance.bannerErrorTextColor)
            
            if let icon = icon {
                view.configureContent(title: title ?? "Error", body: message, iconImage: icon.vcScaleToNewSize(newSize: iconSize))
            }
            else {
                view.configureContent(title: title ?? "Error", body: message)
            }
        }
        else if theme == .info {
            view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerInfoBackgroundColor,
                                foregroundColor: sharedAppearanceManager.appearance.bannerInfoTextColor)
            
            if let icon = icon {
                view.configureContent(title: title ?? "Info", body: message, iconImage: icon.vcScaleToNewSize(newSize: iconSize))
            }
            else {
                view.configureContent(title: title ?? "Info", body: message)
            }
        }
        else if theme == .warning {
            view.configureTheme(backgroundColor: sharedAppearanceManager.appearance.bannerWarningBackgroundColor,
                                foregroundColor: sharedAppearanceManager.appearance.bannerWarningTextColor)
            
            if let icon = icon {
                view.configureContent(title: title ?? "Warning", body: message, iconImage: icon.vcScaleToNewSize(newSize: iconSize))
            }
            else {
                view.configureContent(title: title ?? "Warning", body: message)
            }
        }
        
        // Hides the Button
        view.button?.isHidden = true
        
        DispatchQueue.main.async {
            // Show the banner
            self.bannerMessager.show(config: config, view: view)
        }
    }
    
    /**
     Shows a Banner using a custom UIView as content.
     
     - Parameters:
     - view: The custom view to be used as content.
     - duration: Duration to display de Banner. 0 means forever.
     - dismissesOnTap: Whether the banner hides on tap / pan gesture.
     - dropShadow: Whether the banner should have a shadow along it's borders.
     - windowDimMode: Style that covers the rest of the screen. None, Color, Gray (fade).
     - presentationContext: How the Banner will override the other view. UIWindowLevelStatusBar (covers all including Status Bar), UIWindowLevelNormal (covers all but the Status Bar).
     - presentationDirection: Where the Banner should appear. Top, Bottom.
     */
    public func showCustomBanner(contentView: UIView,
                                 duration: TimeInterval? = nil,
                                 dismissesOnTap: Bool? = nil,
                                 dropShadow: Bool? = nil,
                                 windowDimMode: SwiftMessages.DimMode? = nil,
                                 presentationContext: SwiftMessages.PresentationContext? = nil,
                                 presentationDirection: SwiftMessages.PresentationStyle? = nil) {
        
        let config = self.defaultConfig(duration: duration,
                                        dismissesOnTap: dismissesOnTap,
                                        dropShadow: dropShadow,
                                        windowDimMode: windowDimMode,
                                        presentationContext: presentationContext,
                                        presentationDirection: presentationDirection)
        
        let view = BaseView(frame: CGRectDefault)
        view.installContentView(contentView, insets: UIEdgeInsets.zero)
        view.preferredHeight = contentView.frame.size.height
        
        DispatchQueue.main.async {
            // Show the banner
            self.bannerMessager.show(config: config, view: view)
        }
    }
    
    /** Hides all banners **/
    public func hideBanners() {
        DispatchQueue.main.async {
            self.bannerMessager.hideAll()
        }
    }

    fileprivate func defaultConfig(duration: TimeInterval? = nil,
                                   dismissesOnTap: Bool? = nil,
                                   dropShadow: Bool? = nil,
                                   windowDimMode: SwiftMessages.DimMode? = nil,
                                   presentationContext: SwiftMessages.PresentationContext? = nil,
                                   presentationDirection: SwiftMessages.PresentationStyle? = nil) -> SwiftMessages.Config {
        
        var config = SwiftMessages.Config()
        config.presentationStyle = presentationDirection ?? sharedAppearanceManager.appearance.bannerPresentationDirection
        
        // Display in a window at the specified window level: UIWindowLevelStatusBar
        // displays over the status bar while UIWindowLevelNormal displays under.
        config.presentationContext = presentationContext ?? sharedAppearanceManager.appearance.bannerPresentationContext
        
        // Default auto-hiding behavior.
        let duration: TimeInterval = duration ?? sharedAppearanceManager.appearance.bannerDuration
        if duration > 0 {
            config.duration = .seconds(seconds: duration)
        }
        else {
            config.duration = .forever
        }
        
        // Dim the background like a popover view. Can also hide when the background is tapped.
        config.dimMode = windowDimMode ?? sharedAppearanceManager.appearance.bannerDimMode
        
        // Disable the interactive pan-to-hide gesture.
        config.interactiveHide = dismissesOnTap ?? sharedAppearanceManager.appearance.bannerDismissesOnTap
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .lightContent
        
        return config
    }
}

