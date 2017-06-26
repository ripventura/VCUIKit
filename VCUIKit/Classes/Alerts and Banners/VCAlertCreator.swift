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
    static open func showAlert (
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
}
