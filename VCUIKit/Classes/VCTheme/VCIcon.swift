//
//  VCIcon.swift
//  Pods
//
//  Created by Vitor Cesco on 03/07/17.
//
//

import UIKit

/** UIView that draws itself, simulating an Icon (single colored).*/
@IBDesignable open class VCIcon: VCView {
    @IBInspectable open var fillColor: UIColor = .black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /** Initialize this Icon with a custom Fill Color */
    public convenience init(fillColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.fillColor = fillColor
    }
    
    // MAKR: - Drawing
    
    // Override this with the sub-class custom Icon drawing.
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
