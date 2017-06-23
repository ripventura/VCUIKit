//
//  VCXIBView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/05/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCXIBView: UIView {
    
    @IBOutlet open var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.xibSetup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
