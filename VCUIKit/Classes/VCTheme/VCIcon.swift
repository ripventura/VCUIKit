//
//  VCIcon.swift
//  Pods
//
//  Created by Vitor Cesco on 03/07/17.
//
//

import UIKit

/** UIView that draws itself, simulating an Icon (single colored).*/
@IBDesignable class VCIcon: UIView {
    @IBInspectable var fillColor: UIColor = .black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /** Initialize this Icon with a custom Fill Color */
    convenience init(fillColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.fillColor = fillColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
    }
    
    // MAKR: - Drawing
    
    // Override this with the sub-class custom Icon drawing.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
