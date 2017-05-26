//
//  Labels.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 13/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCLabel: UILabel {
    
    var labelTextColor : UIColor = sharedStyleManager.labelTextColor
    var labelBackgroundColor : UIColor = sharedStyleManager.labelBackgroundColor
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.applyThemeStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyThemeStyle()
    }
    
    // Applies Theme Style after loading
    func applyThemeStyle() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.textColor = labelTextColor
        self.backgroundColor = labelBackgroundColor
    }
}
