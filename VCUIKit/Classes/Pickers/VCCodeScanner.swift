//
//  VCQRCodePicker.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 12/04/17.
//  Copyright © 2017 Vitor Cesco. All rights reserved.
//

import UIKit
import AVFoundation

open class VCCodeScanner: NSObject {
    
    /** Shows a VCCodeScannerViewController.
     
     - Parameters
     - parentViewController: A viewController resposible for presenting the new one.
     - delegate: The VCCodeScannerDelegate to handle scanning calls.
     - scannerViewController: An optional sublclass from VCCodeScannerViewController.
     */
    open static func showScanner(parentViewController: UIViewController,
                                 delegate: VCCodeScannerDelegate,
                                 scannerViewController: VCCodeScannerViewController = VCCodeScannerViewController()) -> Void {
        scannerViewController.delegate = delegate
        parentViewController.present(scannerViewController, animated: true, completion: nil)
    }
}

public protocol VCCodeScannerDelegate {
    /**
     * Called when the scanner scans a valid Code
     */
    func scanner(scanner : VCCodeScannerViewController, didFinnishScanningWithResult result: String)
}

open class VCCodeScannerViewController: VCViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession : AVCaptureSession?
    var captureDevice : AVCaptureDevice?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView?
    
    @IBOutlet var flashSwitch: VCSwitch?
    @IBOutlet var flashLabel: VCLabel?
    @IBOutlet var descriptionLabel: VCLabel?
    @IBOutlet var cancelButton: VCButton?
    
    open var delegate : VCCodeScannerDelegate?
    
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    /** Wheter the viewController should dismiss itself after the first scan occurs */
    open var singleScan: Bool {
        return true
    }
    
    /** Wheter the viewController is ready to evaluate a scanned object */
    open var readyToScan: Bool = true
    
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        self.captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            
            // Populate the interface elements
            self.populateInterface(previewLayer: videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Populates the interface elements
    func populateInterface(previewLayer: AVCaptureVideoPreviewLayer) {
        
        let view = UIView(frame: CGRectDefault)
        self.view.addSubview(view)
        self.view.sendSubview(toBack: view)
        view.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        view.layer.addSublayer(previewLayer)
        
        if self.descriptionLabel == nil {
            self.descriptionLabel = VCLabel(frame: CGRectDefault)
            self.descriptionLabel?.textColor = UIColor.white
            self.descriptionLabel?.shadowColor = UIColor.black
            self.descriptionLabel?.textAlignment = NSTextAlignment.center
            self.descriptionLabel?.numberOfLines = 3
            self.descriptionLabel?.minimumScaleFactor = 0.5
            self.descriptionLabel?.text = "Center the QR code in the camera\nTry avoiding shadows and glares"
            self.view.addSubview(self.descriptionLabel!)
            self.descriptionLabel?.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(self.view).offset(68)
                make.left.equalTo(self.view).offset(8)
                make.right.equalTo(self.view).offset(8)
                make.height.equalTo(80)
            }
        }
        
        
        if self.isFlashAvailable() {
            if self.flashSwitch == nil {
                self.flashSwitch = VCSwitch(frame: CGRectDefault)
                self.flashSwitch?.isOn = false
                self.view.addSubview(self.flashSwitch!)
                flashSwitch!.snp.makeConstraints { (make) -> Void in
                    make.right.equalTo(self.flashSwitch!.superview!).offset(-8)
                    make.top.equalTo(self.flashSwitch!.superview!).offset(20)
                    make.width.equalTo(51)
                    make.height.equalTo(36)
                }
                flashSwitch!.addTarget(self, action: #selector(VCCodeScannerViewController.flashSwitchValueChanged(_:)), for: UIControlEvents.valueChanged)
            }
            
            if self.flashLabel == nil {
                self.flashLabel = VCLabel(frame: CGRectDefault)
                self.flashLabel?.textColor = UIColor.white
                self.flashLabel?.shadowColor = UIColor.black
                self.flashLabel?.textAlignment = NSTextAlignment.right
                self.flashLabel?.minimumScaleFactor = 0.5
                self.flashLabel?.text = "Flash"
                self.view.addSubview(self.flashLabel!)
                self.flashLabel?.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(self.flashSwitch!)
                    make.left.equalTo(self.view).offset(8)
                    make.right.equalTo(self.flashSwitch!.snp.left).offset(-8)
                    make.height.equalTo(self.flashSwitch!)
                }
            }
        }
        else {
            self.flashSwitch?.isHidden = true
            self.flashLabel?.isHidden = true
        }
        
        if self.cancelButton == nil {
            self.cancelButton = VCButton(frame: CGRectDefault)
            self.cancelButton?.setTitle("Cancel", for: UIControlState.normal)
            self.cancelButton?.addTarget(self, action: #selector(VCCodeScannerViewController.cancelButtonPressed(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(self.cancelButton!)
            self.cancelButton?.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(self.cancelButton!.superview!).offset(20)
                make.bottom.equalTo(self.cancelButton!.superview!).offset(-20)
                make.right.equalTo(self.cancelButton!.superview!).offset(-20)
                make.height.equalTo(60)
            }
        }
    }
    
    // Called after the Cancel button has been pressed
    @IBAction func cancelButtonPressed(_ sender : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Called after the Flash Switch changed value
    @IBAction func flashSwitchValueChanged(_ sender : Any) {
        if self.isFlashAvailable() {
            if flashSwitch!.isOn {
                
                do {
                    try captureDevice?.lockForConfiguration()
                    
                    captureDevice?.torchMode = AVCaptureTorchMode.on
                    captureDevice?.unlockForConfiguration()
                }
                catch _ { }
            }
            else {
                do {
                    try captureDevice?.lockForConfiguration()
                    
                    captureDevice?.torchMode = AVCaptureTorchMode.off
                    captureDevice?.unlockForConfiguration()
                }
                catch _ { }
            }
        }
    }
    
    // Wheter this device has flash available
    func isFlashAvailable() -> Bool {
        return self.captureDevice!.isTorchAvailable
    }
    
    // Stops Scanning and dismiss itself
    func finishScanning() {
        self.captureSession?.stopRunning()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // Called after a code is scanned
    open func didScan(code: String) {
        self.delegate?.scanner(scanner: self, didFinnishScanningWithResult: code)
        
        if self.singleScan {
            self.finishScanning()
        }
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if self.readyToScan && metadataObjects != nil && metadataObjects.count > 0 {
            
            // Get the metadata object.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            if supportedCodeTypes.contains(metadataObj.type) {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = barCodeObject!.bounds
                
                if metadataObj.stringValue != nil {
                    self.didScan(code: metadataObj.stringValue)
                    return
                }
            }
        }
        
        qrCodeFrameView?.frame = CGRect.zero
    }
}
