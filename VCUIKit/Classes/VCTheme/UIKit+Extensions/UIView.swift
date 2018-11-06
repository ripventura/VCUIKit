//
//  VCThemedViewController.swift
//  VCSwiftLibrary
//
//  Created by Vitor Cesco on 12/1/15.
//  Copyright © 2015 Vitor Cesco. All rights reserved.
//

import UIKit
import SnapKit

extension UIImageView {
    
}

extension UIView {
    /** View's Corner Radius */
    @IBInspectable var _cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    /** View's Border Width */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    /** View's Border Color */
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /** Adds the View to a given UIView, creating constraints based on the UIEdgeInsets */
    open func addTo(superView: UIView, withConstraint constraintInset: UIEdgeInsets) -> Void {
        
        superView.addSubview(self)
        
        self.snp.makeConstraints({make in
            make.edges.equalTo(superView).inset(constraintInset)
        })
    }
    
    /** Adds a UIMotionEffect translating X and Y axis for this view */
    open func addTranslationMotionEffect(minX: CGFloat = -30, maxX: CGFloat = 30, minY: CGFloat = -30, maxY: CGFloat = 30) {
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = minX
        xMotion.maximumRelativeValue = maxX
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = minY
        yMotion.maximumRelativeValue = maxY
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        self.addMotionEffect(motionEffectGroup)
    }
    
    /** Applies the custom appearance on this UIView */
    @objc open func applyAppearance() -> Void {
        for subview in self.subviews {
            subview.applyAppearance()
        }
    }
    
    // MARK: - Animation
    
    /** Shakes the view sideways */
    open func shake(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.x"
        animation.values = [0 * multiplier, 10 * multiplier, -10 * multiplier, 10 * multiplier, -5 * multiplier, 5 * multiplier, -5 * multiplier, 0 * multiplier]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = CFTimeInterval(duration)
        animation.isAdditive = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "shake")
    }
    
    /** Bounces the view vertically */
    open func bounce(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.y"
        animation.values = [
            0 * multiplier,
            -20 * multiplier,
            0 * multiplier,
            -10 * multiplier,
            0 * multiplier,
            -5 * multiplier,
            0 * multiplier]
        animation.keyTimes = [
            0,
            0.4,
            0.6,
            0.8,
            0.9,
            0.95,
            1]
        animation.duration = CFTimeInterval(duration)
        animation.isAdditive = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "bounce")
    }
    
    /** Grows (scales up) the View on both X and Y axis and reverses */
    open func grow(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "transform.scale"
        animation.values = [1, max(1.1, 1.3 * multiplier)]
        animation.keyTimes = [0, 1]
        animation.duration = CFTimeInterval(duration / 2) //.autoreverses doubles the duration time
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "grow")
    }
    
    /** Shrinks (scales down) the View on both X and Y axis and reverses */
    open func shrink(duration: Float = 0.5, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "transform.scale"
        animation.values = [1, 1 / max(1.1, 1.3 * multiplier)]
        animation.keyTimes = [0, 1]
        animation.duration = CFTimeInterval(duration / 2) //.autoreverses doubles the duration time
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        
        self.layer.add(animation, forKey: "shrink")
    }
    
    /** Swings the View */
    open func swing(duration: Float = 0.35, multiplier: Float = 1) {
        let animation = CAKeyframeAnimation()
        
        let rotationAngle: Double = 15.0 * Double(multiplier)
        
        animation.keyPath = "transform.rotation.z"
        animation.values = [
            0,
            rotationAngle / 180 * Double.pi,
            0,
            -rotationAngle / 180 * Double.pi,
            0
        ]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = CFTimeInterval(duration)
        animation.isRemovedOnCompletion = true
        animation.isAdditive = true
        animation.repeatCount = 2
        
        self.layer.add(animation, forKey: "swing")
    }
}

