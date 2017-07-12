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
    
    /**
     * Called when the scanner scans an invalid code
     */
    func scannerDidFailScanning(scanner : VCCodeScannerViewController)
}

open class VCCodeScannerViewController: VCViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession : AVCaptureSession?
    var captureDevice : AVCaptureDevice?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView?
    
    var flashSwitch : UISwitch?
    
    public var delegate : VCCodeScannerDelegate?
    
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
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Populate the interface elements
            self.populateInterface()
            
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
    func populateInterface() {
        
        let textLabel = UILabel(frame: CGRectDefault)
        textLabel.textColor = UIColor.white
        textLabel.shadowColor = UIColor.black
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.numberOfLines = 3
        textLabel.minimumScaleFactor = 0.5
        textLabel.text = "Center the QR code in the camera\nTry avoiding shadows and glares"
        self.view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(68)
            make.left.equalTo(self.view).offset(8)
            make.right.equalTo(self.view).offset(8)
            make.height.equalTo(80)
        }
        
        if self.isFlashAvailable() {
            flashSwitch = UISwitch(frame: CGRectDefault)
            flashSwitch!.isOn = false
            self.view.addSubview(flashSwitch!)
            flashSwitch!.snp.makeConstraints { (make) -> Void in
                make.right.equalTo(flashSwitch!.superview!).offset(-8)
                make.top.equalTo(flashSwitch!.superview!).offset(20)
                make.width.equalTo(51)
                make.height.equalTo(36)
            }
            flashSwitch!.addTarget(self, action: #selector(VCCodeScannerViewController.flashSwitchValueChanged(sender:)), for: UIControlEvents.valueChanged)
            
            
            let flashLabel = UILabel(frame: CGRectDefault)
            flashLabel.textColor = UIColor.white
            flashLabel.shadowColor = UIColor.black
            flashLabel.textAlignment = NSTextAlignment.right
            flashLabel.minimumScaleFactor = 0.5
            flashLabel.text = "Camera flash"
            self.view.addSubview(flashLabel)
            flashLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(flashSwitch!)
                make.left.equalTo(self.view).offset(8)
                make.right.equalTo(flashSwitch!.snp.left).offset(-8)
                make.height.equalTo(flashSwitch!)
            }
        }
        
        let cancelButton = UIButton(frame: CGRectDefault)
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.addTarget(self, action: #selector(VCCodeScannerViewController.cancelButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(cancelButton.superview!).offset(20)
            make.bottom.equalTo(cancelButton.superview!).offset(-20)
            make.right.equalTo(cancelButton.superview!).offset(-20)
            make.height.equalTo(60)
        }
    }
    
    // Called after the Cancel button has been pressed
    func cancelButtonPressed(sender : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Called after the Flash Switch changed value
    func flashSwitchValueChanged(sender : Any) {
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
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            
            self.delegate?.scannerDidFailScanning(scanner: self)
            
            self.finishScanning()
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                self.delegate?.scanner(scanner: self, didFinnishScanningWithResult: metadataObj.stringValue)
                
                self.finishScanning()
            }
        }
    }
}
