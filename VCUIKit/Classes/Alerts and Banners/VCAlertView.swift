//
//  VCAlertCreator.swift
//  VCSwiftLibrary
//
//  Created by Vitor Cesco on 11/26/15.
//  Copyright © 2015 Vitor Cesco. All rights reserved.
//

import UIKit
import FCAlertView

open class VCAlertView {
    public enum Style {
        case success, error, warning
    }
    
    public struct AlertButton {
        let title : String
        let handler : (() -> Void)
        public init(title : String, handler : @escaping (() -> Void)) {
            self.title = title
            self.handler = handler
        }
    }
    
    public struct AlertIcon {
        /** The icon Image */
        let image : UIImage?
        /** Whether or not this image should be tinted by the Alert Colorscheme */
        let applyTint: Bool
        public init(image: UIImage?, applyTint: Bool = true) {
            self.image = image
            self.applyTint = applyTint
        }
    }
    
    public struct AlertTextfield {
        /** The TextField placeholder text */
        let placeholder : String
        /** Called after the alert is dismissed */
        let didReturn: (String?) -> Void
        public init(placeholder: String, didReturn: @escaping (String?) -> Void) {
            self.placeholder = placeholder
            self.didReturn = didReturn
        }
    }
    
    /**
     Shows an Alert with predefined style
     
     - Parameters:
        - style: Style of the alert. Default is simple.
        - title: The alert title.
        - message: The alert message.
        - defaultButton: The default button.
        - extraButtons: Extra buttons to be available on the alert.
        - roundedButtons: Whether or not the buttons should be rounded or squared.
        - textFields: TextFields to be displayed below the message.
     */
    static open func showAlert (style : Style,
                                title : String?,
                                message : String,
                                defaultButton : AlertButton = AlertButton(title: "Ok", handler: {}),
                                extraButtons : [AlertButton] = [],
                                roundedButtons: Bool? = nil,
                                textFields: [AlertTextfield] = []) -> Void {
        
        let alert = FCAlertView()

        
        // Applies the style
        switch style {
        case .success:
            alert.makeAlertTypeSuccess()
            alert.detachButtons = roundedButtons != nil ? roundedButtons! : true
        case .error:
            alert.makeAlertTypeWarning()
            alert.detachButtons = roundedButtons != nil ? roundedButtons! : true
        case .warning:
            alert.makeAlertTypeCaution()
            alert.detachButtons = roundedButtons != nil ? roundedButtons! : false
        }
        
        self.show(alert: alert,
                  style: style,
                  title: title,
                  message: message,
                  defaultButton: defaultButton,
                  extraButtons: extraButtons,
                  icon: nil,
                  textFields: textFields)
    }
    
    /**
     Shows an Alert
     
     - Parameters:
         - title: The alert title.
         - message: The alert message.
         - defaultButton: The default button.
         - extraButtons: Extra buttons to be available on the alert.
         - roundedButtons: Whether or not the buttons should be rounded or squared.
         - textFields: TextFields to be displayed below the message.
         - icon: Custom AlertIcon to be used as Icon on the top of the alert.
     */
    static open func showAlert (title : String? = nil,
                                message : String,
                                defaultButton : AlertButton = AlertButton(title: "Ok", handler: {}),
                                extraButtons : [AlertButton] = [],
                                roundedButtons: Bool? = nil,
                                textFields: [AlertTextfield] = [],
                                icon : AlertIcon? = nil) -> Void {
        
        let alert = FCAlertView()
        
        
        alert.detachButtons = roundedButtons != nil ? roundedButtons! : false
        
        self.show(alert: alert,
                  style: nil,
                  title: title,
                  message: message,
                  defaultButton: defaultButton,
                  extraButtons: extraButtons,
                  icon: icon,
                  textFields: textFields)
    }
    
    
    static internal func show(alert: FCAlertView,
                              style : Style?,
                              title : String?,
                              message : String,
                              defaultButton : AlertButton,
                              extraButtons : [AlertButton],
                              icon : AlertIcon?,
                              textFields: [AlertTextfield]) -> Void {
        
        // Adds all the buttons
        alert.doneActionBlock(defaultButton.handler)
        for button in extraButtons {
            alert.addButton(button.title, withActionBlock: button.handler)
        }
        
        // Adds all the TextFields
        for textField in textFields {
            alert.addTextField(withPlaceholder: textField.placeholder, andTextReturn: {text in
                textField.didReturn(text)
            })
        }
        
        // Disables dismiss on touch outside
        alert.dismissOnOutsideTouch = false
        
        alert.blurBackground = false
        
        alert.avoidCustomImageTint = icon != nil && !icon!.applyTint
        
        alert._cornerRadius = sharedAppearanceManager.appearance.alertCornerRadius
        alert.titleFont = sharedAppearanceManager.appearance.alertTitleFont
        alert.subtitleFont = sharedAppearanceManager.appearance.alertMessageFont
        
        
        var finalTitle = "Alert";
        if title != nil {
            finalTitle = title!
        } else {
            if let style = style {
                switch style {
                case .success:
                    finalTitle = "Success"
                case .error:
                    finalTitle = "Error"
                case .warning:
                    finalTitle = "Warning"
                }
            }
        }
        
        alert.showAlert(
            withTitle: finalTitle,
            withSubtitle: message,
            withCustomImage: icon?.image,
            withDoneButtonTitle: defaultButton.title,
            andButtons: [])
    }
}
