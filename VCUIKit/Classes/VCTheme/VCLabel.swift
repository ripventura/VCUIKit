//
//  VCLabel.swift
//  Pods
//
//  Created by Vitor Cesco on 23/06/17.
//
//

import UIKit

open class VCLabel: UILabel {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false {
        didSet {
            self.applyAppearance()
        }
    }
    
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
    
    override func applyAppearance() -> Void {
        if !storyboardAppearance {
            self.font = sharedAppearanceManager.labelFont
            self.textColor = sharedAppearanceManager.labelTextColor
        }
    }
}
