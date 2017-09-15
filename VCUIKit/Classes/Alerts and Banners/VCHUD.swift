//
//  VCHUD.swift
//  Pods
//
//  Created by Vitor Cesco on 04/07/17.
//
//

import UIKit
import SVProgressHUD

public let sharedHUD = VCHUD()

open class VCHUD {
    public enum Context: String {
        case success = "Success"
        case error = "Error"
        case info = "Info"
    }
    
    var message : String?
    
    init() {
        self.configureAppearance()
    }
    
    private func configureAppearance() -> Void {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        
        SVProgressHUD.setRingThickness(sharedAppearanceManager.appearance.hudRingWidth)
        SVProgressHUD.setCornerRadius(sharedAppearanceManager.appearance.hudCornerRadius)
        SVProgressHUD.setFont(sharedAppearanceManager.appearance.hudMessageFont)
    }
    
    /**
     Shows a HUD with a Custom Style.
     
     - Parameters:
     - context: The desired Context.
     - message: The message to be displayed.
     */
    open func show(context: Context, message: String) -> Void {
        DispatchQueue.main.async {
            switch context {
            case .error:
                SVProgressHUD.showError(withStatus: message)
            case .success:
                SVProgressHUD.showSuccess(withStatus: message)
            case .info:
                SVProgressHUD.showInfo(withStatus: message)
            }
        }
    }
    
    /**
     Shows a HUD with a progress / indeterminate state.
     
     - Parameters:
     - progress: The progress. Use nil for indeterminate progress.
     - message: The message to be displayed.
     */
    open func show(progress: Float?, message: String?) -> Void {
        DispatchQueue.main.async {
            self.message = message
            if let progress = progress {
                SVProgressHUD.showProgress(progress, status: message)
            } else {
                SVProgressHUD.show(withStatus: message)
            }
        }
    }
    
    /**
     Updates a HUD with a progress / indeterminate state.
     
     - Parameters:
     - progress: The progress. Use nil for indeterminate progress.
     */
    open func update(progress: Float?) -> Void {
        DispatchQueue.main.async {
            if let progress = progress {
                SVProgressHUD.showProgress(progress, status: self.message)
            } else {
                SVProgressHUD.show(withStatus: self.message)
            }
        }
    }
    
    /**
     Dismisses the current HUD.
     
     - Parameters:
     - completion: Block called after the HUD is dismissed.
     */
    open func dismiss(completion: (() -> Void)?) -> Void {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss(completion: completion)
        }
    }
}
