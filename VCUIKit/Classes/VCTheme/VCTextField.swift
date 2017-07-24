//
//  VCTextField.swift
//  Pods
//
//  Created by Vitor Cesco on 19/07/17.
//
//

import UIKit

@IBDesignable open class VCTextField: UITextField {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
        self.listenToAppearanceNotifications()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
        self.listenToAppearanceNotifications()
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    deinit {
        self.removeAppearanceNotifications()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.textColor = sharedAppearanceManager.appearance.textFieldTextColor
            self.font = sharedAppearanceManager.appearance.textFieldTextFont
        }
    }
    
}
