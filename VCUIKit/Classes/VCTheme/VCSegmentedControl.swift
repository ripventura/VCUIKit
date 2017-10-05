//
//  VCSegmentedControl.swift
//  Pods
//
//  Created by Vitor Cesco on 06/07/17.
//
//

import UIKit

@IBDesignable open class VCSegmentedControl : UISegmentedControl {
    /** Whether the appearance is being set manually on Storyboard */
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
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.tintColor = sharedAppearanceManager.appearance.segmentedControlTintColor
        }
    }
}
