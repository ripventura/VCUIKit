//
//  VCSignaturePicker.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/3/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import EPSignature
import DCAnimationKit

public protocol VCSignaturePickerViewControllerDelegate {
    /**
     * Called when the user hits the Done button
     */
    func signaturePickerViewController(controller : VCSignaturePickerViewController, didFinnishSigning isSigned : Bool, withSignedImage signatureImage : UIImage?)
}

open class VCSignaturePickerViewController: VCViewController {
    private var signatureView : VCSignatureView?
    
    public var delegate : VCSignaturePickerViewControllerDelegate?
    
    var signatureRatio : (CGFloat)?
    var doneButton : UIButton?
    var identifier : String?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        signatureView = VCSignatureView(frame: CGRectDefault)
        if self.signatureRatio == nil {
            signatureView!.addToSuperViewWithConstraints(superview: self.view, constraintInset: UIEdgeInsets.zero)
        }
        else {
            self.view.addSubview(signatureView!)
            
            signatureView!.snp.makeConstraints { make in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.center.equalTo(self.view)
                make.height.equalTo(self.view.snp.width).dividedBy(signatureRatio!)
            }
        }
        
        doneButton = UIButton(frame: CGRectDefault)
        doneButton!.setTitle("Done", for: .normal)
        doneButton!.addTarget(self, action: #selector(self.doneButtonPressed), for: .touchUpInside)
        doneButton!.setTitleColor(sharedStyleManager.viewControllerViewTintColor, for: .normal)
        self.view.addSubview(doneButton!)
        doneButton!.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-20)
            make.right.equalTo(self.view).offset(-20)
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    @objc private func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        if self.delegate != nil {
            self.delegate!.signaturePickerViewController(controller: self, didFinnishSigning: self.signatureView!.isSigned, withSignedImage: self.signatureView!.getSignatureAsImage())
        }
    }
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
}

open class VCSignatureView: EPSignatureView {
    @IBOutlet var signatureStrokeColor : UIColor? = sharedStyleManager.signatureViewStrokeColor
    @IBOutlet var signatureBackgroundColor : UIColor? = sharedStyleManager.signatureViewBackgroundColor
    
    private var statusLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyTheme()
        self.prepareInterface()
        _ = self.becomeFirstResponder()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.applyTheme()
        self.prepareInterface()
    }
    
    
    private func applyTheme() {
        self.strokeColor = signatureStrokeColor!
        self.backgroundColor = signatureBackgroundColor!
    }
    
    private func prepareInterface() {
        statusLabel = UILabel(frame: CGRectDefault)
        statusLabel!.textAlignment = .center
        statusLabel!.alpha = 0.5
        self.addSubview(statusLabel!)
        
        
        statusLabel!.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(self)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self)
        }
    }
    
    
    override open func getSignatureAsImage() -> UIImage? {
        self.statusLabel?.isHidden = true
        let img = super.getSignatureAsImage()
        self.statusLabel?.isHidden = false
        return img
    }
    
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _ = self.becomeFirstResponder()
    }
    
    override open func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        statusLabel!.text = "shake device to clear signature"
        
        return true
    }
    
    override open func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        statusLabel!.text = "draw signature"
        
        return true
    }
    
    override open var canBecomeFirstResponder : Bool {
        return true
    }
    
    
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.shake({
                self.clear()
            })
        }
    }
}
