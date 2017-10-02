//
//  VCToolbar.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 02/10/17.
//

import UIKit

@IBDesignable class VCToolbar: UIToolbar {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    override public init(frame: CGRect) {
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
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            print(sharedAppearanceManager.appearance.toolbarTintColor)
            self.tintColor = sharedAppearanceManager.appearance.toolbarTintColor
        }
    }
}
