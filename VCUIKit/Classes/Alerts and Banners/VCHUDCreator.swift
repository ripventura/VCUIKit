//
//  VCHUDCreator.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/18/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import SwiftMessages
import SWActivityIndicatorView

public let sharedHUDCreator : VCHUDCreator = VCHUDCreator()

open class VCHUDCreator {
    
    var hudMessager : SwiftMessages
    var hasVisibleHUD : Bool
    private var cancelHandler : (() -> Void)
    
    init() {
        hudMessager = SwiftMessages()
        hudMessager.pauseBetweenMessages = 0
        
        hasVisibleHUD = false
        
        cancelHandler = {}
    }
    
    /**
     * Shows a HUD with the given parameters
     *
     * Message: Message being displayed.
     * cancelHandler: The handler to be called after the cancel button is pressed. If nil, the button will be hidden.
     */
    public func showHUD(message : String, hiddenCancel : Bool? = nil, cancelHandler : (() -> Void)? = nil) {
        if (cancelHandler != nil) {
            self.cancelHandler = cancelHandler!
        } else {
            self.cancelHandler = {}
        }
        
        // If there's any HUD being shown at the moment
        if hasVisibleHUD {
            var stateDict : [String:Any] = ["message" : message];
            
            if hiddenCancel != nil {
                stateDict["hiddenCancel"] = hiddenCancel!
            }
            // Updates it's state
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HUD_STATE_UPDATE"),
                                            object: nil,
                                            userInfo: stateDict)
        }
        else {
            self.showNewHUD(message: message, hiddenCancel: hiddenCancel == nil || hiddenCancel!)
        }
    }
    
    /**
     * Hides the HUD
     */
    public func hideHUD() {
        DispatchQueue.main.async {
            self.hudMessager.hide()
            self.hasVisibleHUD = false
            self.cancelHandler = {}
        }
    }
    
    
    private func showNewHUD(message : String, hiddenCancel : Bool) {
        let contentView = CustomHUD(frame: CGRect(x: 0, y: 0, width: 100, height: 78))
        contentView.setup(message: message)
        contentView.cancelButton?.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        contentView.cancelButton?.isHidden = hiddenCancel
        
        self.hasVisibleHUD = true
        
        DispatchQueue.main.async {
            self.showCustomBanner(contentView: contentView,
                                  duration: 0,
                                  dismissesOnTap: false,
                                  dropShadow: true,
                                  windowDimMode: .gray(interactive: false),
                                  presentationContext: .window(windowLevel: UIWindowLevelStatusBar),
                                  presentationDirection: .bottom)
        }
    }
    private func showCustomBanner(contentView : UIView,
                                  duration : TimeInterval,
                                  dismissesOnTap : Bool,
                                  dropShadow : Bool,
                                  windowDimMode : SwiftMessages.DimMode,
                                  presentationContext : SwiftMessages.PresentationContext,
                                  presentationDirection : SwiftMessages.PresentationStyle) {
        
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
            self.hudMessager.show(config: config, view: view)
        }
    }
    
    
    @objc private func cancelButtonPressed() {
        self.hideHUD()
        self.cancelHandler()
    }
}

private class CustomHUD: UIView {
    var messageLabel : UILabel?
    var cancelButton : XIconButton?
    
    func setup(message : String) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMessage(notification:)), name: NSNotification.Name(rawValue: "HUD_STATE_UPDATE"), object: nil)
        
        
        self.backgroundColor = sharedAppearance.hudBackgroundColor
        self.tintColor = sharedAppearance.hudTintColor
        
        let spinner = SWActivityIndicatorView(frame: CGRectDefault)
        spinner.lineWidth = 3
        spinner.autoStartAnimating = true
        spinner.hidesWhenStopped = false
        spinner.color = sharedAppearance.hudTintColor
        spinner.backgroundColor = UIColor.clear
        self.addSubview(spinner)
        spinner.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 34, height: 34))
            make.centerY.equalTo(self)
            make.left.equalTo(20)
        }
        
        cancelButton = XIconButton(frame: CGRectDefault)
        self.addSubview(cancelButton!)
        cancelButton!.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        messageLabel = UILabel(frame: CGRectDefault)
        messageLabel?.textColor = sharedAppearance.hudMessageColor
        messageLabel?.text = message
        self.addSubview(messageLabel!)
        messageLabel!.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(spinner.snp.right).offset(20)
            make.right.equalTo(cancelButton!.snp.left).offset(-8)
            make.height.equalTo(34)
            make.centerY.equalTo(self)
        }
    }
    
    func updateMessage(notification : Notification) {
        self.messageLabel?.text = notification.userInfo?["message"] as? String
        
        if notification.userInfo!["hiddenCancel"] as? Bool != nil {
            self.cancelButton?.isHidden = notification.userInfo!["hiddenCancel"] as! Bool
        }
    }
}

class XIconButton: VCDrawableButton {
    /** Override this with the Drawing method for Normal state. */
    open override func drawNormal(rect : CGRect) {
        VCUIKitStyleKit.drawRoundedXIcon(frame: rect, resizing: .aspectFill)
    }
    
    /** Override this with the Drawing method for Pressed state. */
    open override func drawPressed(rect : CGRect) {
        VCUIKitStyleKit.drawRoundedXIcon(frame: rect, resizing: .aspectFill)
    }
}
