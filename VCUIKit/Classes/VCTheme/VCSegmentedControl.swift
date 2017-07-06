//
//  VCSegmentedControl.swift
//  Pods
//
//  Created by Vitor Cesco on 06/07/17.
//
//

import UIKit

open class VCSegmentedControl : UISegmentedControl {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
    }
    public override init(items: [Any]?) {
        super.init(items: items)
        
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
            self.tintColor = sharedAppearanceManager.segmentedControlTintColor
        }
    }
}
