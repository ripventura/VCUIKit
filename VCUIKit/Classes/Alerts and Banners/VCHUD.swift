//
//  VCHUD.swift
//  Pods
//
//  Created by Vitor Cesco on 04/07/17.
//
//

import UIKit
import KVNProgress

public let sharedHUD = VCHUD()

open class VCHUD {
    /** Standard configuration based on the Appearance Manager */
    private func configuration(stopHandler: ((Void) -> Void)?) -> KVNProgressConfiguration {
        let configuration = KVNProgressConfiguration()
        
        //configuration.statusColor = sharedAppearanceManager.hudMessageColor
        configuration.statusFont = sharedAppearanceManager.hudMessageFont
        //configuration.circleStrokeForegroundColor = .red
        //configuration.circleStrokeBackgroundColor = .blue
        //configuration.circleFillBackgroundColor = .purple
        //configuration.backgroundFillColor = .orange
        //configuration.backgroundTintColor = .yellow
        //configuration.successColor = .green
        //configuration.errorColor = .brown
        configuration.stopColor = sharedAppearanceManager.hudTintColor
        configuration.circleSize = sharedAppearanceManager.hudCircleSize
        configuration.lineWidth = sharedAppearanceManager.hudLineWidth
        configuration.isFullScreen = sharedAppearanceManager.hudFullScreen
        
        if let stopHandler = stopHandler {
            configuration.doesShowStop = true
            configuration.tapBlock = {progress in
                self.dismiss(completion: {
                    stopHandler()
                })
            }
            
        } else {
            configuration.doesShowStop = false
        }
        configuration.stopRelativeHeight = 0.4
        
        return configuration
    }
    
    public enum CustomStyle: String {
        case success = "Success"
        case error = "Error"
    }
    
    // MARK: - Show
    
    /**
     Shows a HUD with a Custom Style.
     
     - Parameters:
        - customStyle: The desired CustomStyle.
        - message: The message to be displayed.
        - onView: A parent view to hold the HUD (default is window).
        - configuration: Custom configuration to be used.
     */
    open func show(customStyle: CustomStyle, message: String, onView: UIView? = nil, configuration: KVNProgressConfiguration? = nil) -> Void {
        KVNProgress.setConfiguration(configuration != nil ? configuration! : self.configuration(stopHandler: nil))
        
        if let onView = onView {
            if customStyle == .success {
                KVNProgress.showSuccess(withStatus: message, on: onView)
            } else if customStyle == .error {
                KVNProgress.showError(withStatus: message, on: onView)
            }
        } else {
            if customStyle == .success {
                KVNProgress.showSuccess(withStatus: message)
            } else if customStyle == .error {
                KVNProgress.showError(withStatus: message)
            }
        }
    }
    
    /**
     Shows a HUD with a progress / indeterminate state.
     
     - Parameters:
        - progress: The progress. Use nil for indeterminate progress.
        - message: The message to be displayed.
        - onView: A parent view to hold the HUD (default is window).
        - configuration: Custom configuration to be used.
     */
    open func show(progress: CGFloat?, message: String, onView: UIView? = nil, configuration: KVNProgressConfiguration? = nil, cancelHandler: ((Void) -> Void)? = nil) -> Void {
        KVNProgress.setConfiguration(configuration != nil ? configuration! : self.configuration(stopHandler: cancelHandler))
        
        if let onView = onView {
            if let progress = progress {
                KVNProgress.show(progress, status: message, on: onView)
            } else {
                KVNProgress.show(withStatus: message, on: onView)
            }
        } else {
            if let progress = progress {
                KVNProgress.show(progress, status: message)
            } else {
                KVNProgress.show(withStatus: message)
            }
        }
    }
    
    // MARK: - Update
    
    /**
     Updates the progress HUD.
     
     - Parameters:
        - progress: The progress. Use nil for indeterminate progress.
     */
    open func update(progress: CGFloat) -> Void {
        KVNProgress.update(progress, animated: true)
    }
    
    /**
     Updates the HUD status.
     
     - Parameters:
        - message: The message to be displayed.
     */
    open func update(message: String) -> Void {
        KVNProgress.updateStatus(message)
    }
    
    // MARK: - Dismiss
    
    /**
     Dismiss the current HUD.
 
     - Parameters:
        - completion: Block called after the HUD is dismissed. 
     */
    open func dismiss(completion: ((Void) -> Void)?) -> Void {
        KVNProgress.dismiss(completion: {
            completion?()
        })
    }
}
