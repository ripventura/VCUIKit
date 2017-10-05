//
//  VCProgressView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 05/10/17.
//

import UIKit

open class VCProgressView: UIProgressView {
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.applyAppearance()
    }
    
    override open func applyAppearance() {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.trackTintColor = sharedAppearanceManager.appearance.progressViewTrackTintColor
            self.progressTintColor = sharedAppearanceManager.appearance.progressViewProgressTintColor
        }
    }
}
