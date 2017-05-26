//
//  VCAlertCreator.swift
//  VCSwiftLibrary
//
//  Created by Vitor Cesco on 11/26/15.
//  Copyright © 2015 Vitor Cesco. All rights reserved.
//

import UIKit
import FCAlertView

open class VCAlertCreator {
    
    public enum CommonErros: String {
        case ConnectionFailed = "Could not connect to server. Please try again."
        case UnknownServerResponse = "There was a problem with the server result. Please try again."
        case InvalidLogin = "Incorrect username or password."
        case Unauthorized = "Unauthorized to access this information. Please try again."
    }
    
    public enum Style {
        case Success
        case Error
        case Warning
    }
    
    public struct AlertButton {
        let title : String
        let handler : (() -> Void)
        public init(title : String, handler : @escaping (() -> Void)) {
            self.title = title
            self.handler = handler
        }
    }
    
    /**
     * Shows an Alert with the given parameters
     *
     * Style: Success, Caution, Warning, Nil (default simple theme)
     * Title: The Alert title
     * Message: The Alert message
     * IconImage: Custom image to be used as Icon on the top
     * DoneButton: The AlertButton representing the done (default) button
     * Buttons: An Array of extra AlertButton to be used
     */
    public func showAlert (
        style : Style? = nil,
        title : String? = nil,
        message : String,
        iconImage : UIImage? = nil,
        doneButton : AlertButton = AlertButton(title: "Dismiss", handler: {}),
        buttons : [AlertButton] = []) -> Void {
        
        sharedBannerCreator.hideBanners()
        sharedHUDCreator.hideHUD()
        
        let alert = FCAlertView()
        
        var finalTitle = "Alert";
        if title != nil {
            finalTitle = title!
        } else {
            if style != nil {
                switch style! {
                case .Success:
                    finalTitle = "Success"
                case .Error:
                    finalTitle = "Error"
                case .Warning:
                    finalTitle = "Warning"
                }
            }
        }
        alert.showAlert(
            withTitle: finalTitle,
            withSubtitle: message,
            withCustomImage: iconImage,
            withDoneButtonTitle: doneButton.title,
            andButtons: [])
        
        // Adds all the buttons
        alert.doneActionBlock(doneButton.handler)
        for button in buttons {
            alert.addButton(button.title, withActionBlock: button.handler)
        }
        
        // Disables dismiss on touch outside
        alert.dismissOnOutsideTouch = false
        
        // Applies the style
        if style != nil {
            switch style! {
            case .Success:
                alert.makeAlertTypeSuccess()
                
            case .Error:
                alert.makeAlertTypeWarning()
            case .Warning:
                alert.makeAlertTypeCaution()
            }
        }
    }
    
    public init() {
        
    }
}
