//
//  VCPlaceholderView.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 01/03/18.
//

import Foundation

open class VCPlaceholderView: VCView {
    open var placeHolderDrawableView : VCDrawableView = VCDrawableView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeHolderTitleLabel : VCLabel = VCLabel()
    open var placeHolderTextLabel : VCLabel = VCLabel()
    open var placeHolderActionButton : VCButton = VCButton()
    
    var actionHandler: (() -> Void)?
    
    open var isEnabled: Bool {
        get {
            return !self.isHidden
        }
        set(newValue) {
            self.isHidden = !newValue
        }
    }
    
    /** Updates the placeholders */
    open func update(enable: Bool,
                     title: String? = nil,
                     text: String? = nil,
                     drawer: VCDrawerProtocol? = nil,
                     activity: Bool = false,
                     buttonTitle: String? = nil) {
        self.isEnabled = enable
        self.placeHolderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderDrawableView.drawer = drawer
        if activity {
            self.placeHolderActivityIndicatorView.startAnimating()
        } else {
            self.placeHolderActivityIndicatorView.stopAnimating()
        }
        self.placeHolderActionButton.setTitle(buttonTitle, for: .normal)
        self.placeHolderActionButton.isHidden = buttonTitle == nil
    }
    
    /** Sets up the PlaceholderView */
    open func setup(actionHandler: @escaping (() -> Void)) {
        self.actionHandler = actionHandler
        
        self.backgroundColor = .clear
        
        self.placeHolderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTitleLabel.textAlignment = .center
        self.placeHolderTitleLabel.numberOfLines = 0
        self.addSubview(self.placeHolderTitleLabel)
        placeHolderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self).offset(48)
            make.right.equalTo(self).offset(-48)
            make.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(25)
        })
        
        self.placeHolderDrawableView.backgroundColor = .clear
        self.addSubview(self.placeHolderDrawableView)
        placeHolderDrawableView.snp.makeConstraints({make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.placeHolderTitleLabel.snp.top).offset(-20)
            make.size.equalTo(sharedAppearanceManager.appearance.placeholderViewImageSize)
        })
        
        self.addSubview(self.placeHolderActivityIndicatorView)
        self.placeHolderActivityIndicatorView.hidesWhenStopped = true
        placeHolderActivityIndicatorView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeHolderDrawableView)
            make.centerY.equalTo(self.placeHolderDrawableView)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        self.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(self.placeHolderTitleLabel)
            make.right.equalTo(self.placeHolderTitleLabel)
            make.top.equalTo(self.placeHolderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        self.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.actionButtonPressed), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.left.equalTo(self.placeHolderTitleLabel)
            make.right.equalTo(self.placeHolderTitleLabel)
            make.height.equalTo(40)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
        
        self.isEnabled = false
    }
    
    @objc fileprivate func actionButtonPressed() {
        self.actionHandler?()
    }
    
    override open func applyAppearance() {
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.placeholderViewTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.placeholderViewTextFont
        
        self.placeHolderTitleLabel.textColor = sharedAppearanceManager.appearance.placeholderViewTitleColor
        self.placeHolderTitleLabel.font = sharedAppearanceManager.appearance.placeholderViewTitleFont
        
        self.placeHolderDrawableView.snp.updateConstraints({make in
            make.size.equalTo(sharedAppearanceManager.appearance.placeholderViewImageSize)
        })
        
        self.placeHolderActionButton.tintColor = sharedAppearanceManager.appearance.placeholderViewButtonTintColor
        self.placeHolderActionButton.titleLabel?.font = sharedAppearanceManager.appearance.placeholderViewButtonFont
        
        self.placeHolderActivityIndicatorView.applyAppearance()
    }
}
