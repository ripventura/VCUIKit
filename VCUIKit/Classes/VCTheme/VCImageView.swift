//
//  VCImageView.swift
//  Pods
//
//  Created by Vitor Cesco on 27/06/17.
//
//

import UIKit

@IBDesignable open class VCImageView: UIImageView {
    /** Manually set the Blur Effect Style on Storyboard.
     
     extraLight = 0
     
     light = 1
     
     dark = 2
     
     @available(iOS 10.0, *)
     regular = 3 // Adapts to user interface style
     
     @available(iOS 10.0, *)
     prominent = 4 // Adapts to user interface style
     */
    @IBInspectable open var blurEffectStyle: Int = -1 {
        didSet {
            if blurEffectStyle >= 0 {
                self.applyBlurEffect(style: UIBlurEffectStyle(rawValue: blurEffectStyle)!)
            }
        }
    }
    
    var visualEffectView : UIVisualEffectView = UIVisualEffectView(effect: nil)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
    }
    public override init(image: UIImage?) {
        super.init(image: image)
        
        self.applyAppearance()
    }
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        self.applyAppearance()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
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
        
        self.visualEffectView.addTo(superView: self,
                                    withConstraint:  UIEdgeInsets(top: 0,
                                                                  left: 0,
                                                                  bottom: 0,
                                                                  right: 0))
    }
}
