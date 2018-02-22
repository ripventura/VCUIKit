//
//  VCAlert.swift
//  Pods
//
//  Created by Vitor Cesco on 19/07/17.
//
//

import UIKit

open class VCSystemAlert {
    /**
     Shows a system Alert.
     
     - Parameters:
         - style: Style of the alert.
         - title: The alert title.
         - message: The alert message.
         - actions: The Actions (buttons) to be displayed on the alert.
         - viewController: The UIViewController presenting the alert.
         - sourceView: Used (and required) only on iPad (actionSheet style), is used as the 'popoverPresentationController' sourceView.
     */
    static open func show(style: UIAlertControllerStyle,
                          withTitle title: String?,
                          withMessage message: String?,
                          withActions actions: [UIAlertAction]?,
                          fromViewController viewController: UIViewController,
                          withSourceView sourceView: UIView?) -> Void {
        let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: style)
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        }
        else {
            alertController.addAction(.init(title: "Ok", style: .default, handler: nil))
        }
        if UIDevice.current.userInterfaceIdiom == .pad && style == .actionSheet {
            if let sourceView = sourceView {
                if let popoverController = alertController.popoverPresentationController {
                    popoverController.sourceView = sourceView
                    popoverController.sourceRect = CGRect(x: sourceView.bounds.midX,
                                                          y: sourceView.bounds.midY,
                                                          width: 0,
                                                          height: 0)
                }
            } else {
                fatalError("SourceView is required on all 'pad' userInterfaceIdiom.")
            }
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
