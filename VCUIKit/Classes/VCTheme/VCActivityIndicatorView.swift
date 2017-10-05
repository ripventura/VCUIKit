//
//  VCActivityIndicatorView.swift
//  Pods
//
//  Created by Vitor Cesco on 17/07/17.
//
//

import UIKit

@IBDesignable open class VCActivityIndicatorView : UIActivityIndicatorView {
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
    }
    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    public override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
        
        self.applyAppearance()
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
            self.color = sharedAppearanceManager.appearance.activityIndicatorTintColor
        }
    }
}
