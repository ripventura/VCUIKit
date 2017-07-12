//
//  Buttons.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCButton : UIButton {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    override func applyAppearance() -> Void {
        if !storyboardAppearance {
            self.titleLabel?.font = sharedAppearanceManager.buttonFont
            self.setTitleColor(sharedAppearanceManager.buttonTintColor, for: .normal)
        }
    }
}

/** A UIButton that draws itself. Should be used with PaintCode drawings. */
@IBDesignable open class VCDrawableButton : VCButton {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.setNeedsDisplay()
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.setNeedsDisplay()
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        self.setNeedsDisplay()
    }
    
    override open func draw(_ rect: CGRect) {
        if self.isHighlighted || self.isSelected {
            self.drawPressed(rect: rect)
        } else {
            self.drawNormal(rect: rect)
        }
    }
    
    
    /** Override this with the Drawing method for Normal state. */
    open func drawNormal(rect : CGRect) {
        
    }
    
    /** Override this with the Drawing method for Pressed state. */
    open func drawPressed(rect : CGRect) {
        
    }
}
