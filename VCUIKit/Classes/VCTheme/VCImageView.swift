//
//  VCImageView.swift
//  Pods
//
//  Created by Vitor Cesco on 27/06/17.
//
//

import UIKit

open class VCImageView: UIImageView {
    /** Manually set the Blur Effect Style on Storyboard. 
     
     extraLight = 0
     
     light = 1
     
     dark = 2
     
     @available(iOS 10.0, *)
     regular = 3 // Adapts to user interface style
     
     @available(iOS 10.0, *)
     prominent = 4 // Adapts to user interface style
     */
    @IBInspectable open var blurEffectStyle: Int = -1
    
    var visualEffectView : UIVisualEffectView = UIVisualEffectView(effect: nil)
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if blurEffectStyle >= 0 {
            self.applyBlurEffect(style: UIBlurEffectStyle(rawValue: blurEffectStyle)!)
        }
    }
    
    // MARK: Effects
    
    /** Applies a Blur Effect */
    open func applyBlurEffect(style: UIBlurEffectStyle) -> Void {
        self.applyEffect(effect: UIBlurEffect(style: style))
    }
    
    // MARK: Helpers
    
    internal func applyEffect(effect: UIVisualEffect) {
        self.visualEffectView.removeFromSuperview()
        self.visualEffectView.removeConstraints(self.visualEffectView.constraints)
        
        self.visualEffectView = UIVisualEffectView(effect: effect)
        
        self.visualEffectView.addToSuperViewWithConstraints(superview : self,
                                                            constraintInset : UIEdgeInsets(top: 0,
                                                                                           left: 0,
                                                                                           bottom: 0,
                                                                                           right: 0))
    }
}
