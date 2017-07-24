//
//  VCView.swift
//  Pods
//
//  Created by Vitor Cesco on 11/07/17.
//
//

import UIKit

@IBDesignable open class VCView : UIView {
    
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
}
