//
//  VCSwitch.swift
//  Pods
//
//  Created by Vitor Cesco on 14/07/17.
//
//

import UIKit

@IBDesignable open class VCSwitch : UISwitch {
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
            self.thumbTintColor = sharedAppearanceManager.switchThumbColor
            self.onTintColor = sharedAppearanceManager.switchTintColor
        }
    }
}
