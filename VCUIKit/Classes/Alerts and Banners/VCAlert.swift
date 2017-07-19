//
//  VCAlert.swift
//  Pods
//
//  Created by Vitor Cesco on 19/07/17.
//
//

import UIKit

open class VCAlert {
    /**
     Shows a system Alert.
     
     - Parameters:
         - style: Style of the alert.
         - title: The alert title.
         - message: The alert message.
         - actions: The Actions (buttons) to be displayed on the alert.
         - viewController: The UIViewController presenting the alert.
     */
    static open func show(style: UIAlertControllerStyle,
                          withTitle title: String?,
                          withMessage message: String?,
                          withActions actions: [UIAlertAction],
                          fromViewController viewController: UIViewController) -> Void {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: style)
        for action in actions {
            alertViewController.addAction(action)
        }
        
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}
