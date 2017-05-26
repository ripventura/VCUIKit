//
//  Buttons.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCDrawableButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyThemeStyle()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.applyThemeStyle()
    }
    
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
    
    // Applies Theme Style after loading
    func applyThemeStyle() {
    }
    
    // Override this with the Drawing method for Normal state
    internal func drawNormal(rect : CGRect) {
        
    }
    
    // Override this with the Drawing method for Pressed state
    internal func drawPressed(rect : CGRect) {
        
    }
}

/** Flat Themed UIButton **/
@IBDesignable open class VCFlatButton : VCDrawableButton {
    
    var buttonBackgroundColor : UIColor = sharedStyleManager.flatButtonBackgroundColor
    var buttonShadowColor : UIColor = sharedStyleManager.flatButtonShadowColor
    var buttonNormalTitleColor : UIColor = sharedStyleManager.flatButtonNormalTitleColor
    var buttonPressedTitleColor : UIColor = sharedStyleManager.flatButtonPressedTitleColor
    var buttonShadowHeight : CGFloat = sharedStyleManager.flatButtonShadowHeight
    var buttonCornerRadius : CGFloat = sharedStyleManager.flatButtonCornerRadius
    
    
    // Applies Theme Style after loading
    override func applyThemeStyle() {
        self.setTitleColor(buttonNormalTitleColor, for: .normal)
        self.setTitleColor(buttonPressedTitleColor, for: .highlighted)
        self.setTitleColor(buttonPressedTitleColor, for: .selected)
    }
    
    // Override this with the Drawing method for Normal state
    internal override func drawNormal(rect : CGRect) {
        VCUIKitStyleKit.drawVCFlatUIButtonNormal(vCFlatUIButtonSize: self.bounds.size,
                                                 vCFlatUIButtonShadowHeight: buttonShadowHeight,
                                                 vCFlatUIButtonCornerRadius: buttonCornerRadius)
    }
    
    // Override this with the Drawing method for Pressed state
    internal override func drawPressed(rect : CGRect) {
        VCUIKitStyleKit.drawVCFlatUIButtonPressed(vCFlatUIButtonSize: self.bounds.size,
                                                  vCFlatUIButtonShadowHeight: buttonShadowHeight,
                                                  vCFlatUIButtonCornerRadius: buttonCornerRadius)
    }
}

/** Squared Icon UIButton **/
@IBDesignable open class VCIconButton : VCDrawableButton {
    
    enum IconType {
        case RoundedX
    }
    
    // Type of the icon used on this Button
    private var iType : VCIconButton.IconType = .RoundedX
    
    // Use this to change the Button Icon Type
    @IBInspectable var iconType: IconType {
        get {
            return self.iType
        }
        set {
            self.iType = newValue
            self.setNeedsDisplay()
        }
    }
    
    var buttonFillColor : UIColor = sharedStyleManager.iconButtonFillColor
    
    // Applies Theme Style after loading
    override func applyThemeStyle() {
        self.backgroundColor = UIColor.clear
        self.showsTouchWhenHighlighted = true
    }
    
    // Override this with the Drawing method for Normal state
    internal override func drawNormal(rect : CGRect) {
        switch self.iconType {
        case .RoundedX:
            VCUIKitStyleKit.drawRoundedXIcon(frame: self.bounds, resizing: .aspectFill)
        }
    }
    
    // Override this with the Drawing method for Pressed state
    internal override func drawPressed(rect : CGRect) {
        self.drawNormal(rect: rect)
    }
}
