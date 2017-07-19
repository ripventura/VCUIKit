//
//  VCLabel.swift
//  Pods
//
//  Created by Vitor Cesco on 23/06/17.
//
//

import UIKit

@IBDesignable open class VCLabel: UILabel {
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
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.font = sharedAppearanceManager.appearance.labelFont
            self.textColor = sharedAppearanceManager.appearance.labelTextColor
        }
    }
}
