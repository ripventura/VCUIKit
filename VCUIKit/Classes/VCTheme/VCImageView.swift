//
//  VCImageView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 23/10/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCImageView: UIImageView {
    @IBInspectable open var drawFillColor: UIColor = .black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable open var drawBackgroundColor: UIColor = .clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    open var drawer: VCDrawerProtocol? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    public convenience init(fillColor: UIColor, backgroundColor: UIColor, drawer: VCDrawerProtocol? = nil, frame: CGRect) {
        self.init(frame: frame)
        self.drawFillColor = fillColor
        self.drawBackgroundColor = backgroundColor
        self.drawer = drawer
    }
    
    override open func draw(_ rect: CGRect) {
        drawer?.draw(rect: rect, fillColor: self.drawFillColor, backgroundColor: self.drawBackgroundColor)
    }
}

public protocol VCDrawerProtocol {
    func draw(rect: CGRect, fillColor: UIColor, backgroundColor: UIColor)
}

