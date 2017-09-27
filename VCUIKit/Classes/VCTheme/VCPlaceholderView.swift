//
//  VCPlaceholderView.swift
//  FCAlertView
//
//  Created by Vitor Cesco on 27/09/17.
//

import UIKit

open class VCPlaceholderView: VCView {
    open var placeHolderImageView : VCImageView = VCImageView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeholderTitleLabel : VCLabel = VCLabel()
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
                     image: UIImage? = nil,
                     activity: Bool = false,
                     buttonTitle: String? = nil) {
        self.isEnabled = enable
        self.placeholderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderImageView.image = image
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
        
        let centerYOffset = -80
        
        self.addSubview(self.placeHolderImageView)
        placeHolderImageView.snp.makeConstraints({make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).offset(centerYOffset)
            make.width.equalTo(100)
            make.height.equalTo(100)
        })
        
        self.addSubview(self.placeHolderActivityIndicatorView)
        self.placeHolderActivityIndicatorView.hidesWhenStopped = true
        placeHolderActivityIndicatorView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeHolderImageView)
            make.centerY.equalTo(self.placeHolderImageView)
        })
        
        self.placeholderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleColor
        self.placeholderTitleLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleFont
        self.placeholderTitleLabel.textAlignment = .center
        self.placeholderTitleLabel.numberOfLines = 0
        self.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.snp.centerY).offset(centerYOffset + 20)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        self.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.placeholderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        self.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.actionButtonPressed), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
        
        self.isEnabled = false
    }
    
    @objc fileprivate func actionButtonPressed() {
        self.actionHandler?()
    }
}
