//
//  VCCollectionViewCell.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

open class VCCollectionViewCell: UICollectionViewCell {
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
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
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.contentView.backgroundColor = sharedAppearanceManager.appearance.collectionViewCellBackgroundColor
            self.backgroundColor = sharedAppearanceManager.appearance.collectionViewCellBackgroundColor
            
            self.tintColor = sharedAppearanceManager.appearance.collectionViewCellTintColor
        }
    }
}
