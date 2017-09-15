//
//  VCMediaPicker.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/23/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import Foundation

open class VCMediaPicker: NSObject {
    
    /** Shows a Media Picker from the iOS Albums */
    open static func showAlbumMediaPicker(delegateViewController: UIViewController) {
        
        // If the device has support for the asked sourceType
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = self.pickerController(delegateViewController: delegateViewController)
            
            pickerController.sourceType = .photoLibrary
            
            if #available(iOS 11.0, *) {
                pickerController.imageExportPreset = .compatible
            }
            
            DispatchQueue.main.async {
                delegateViewController.present(pickerController, animated: true, completion: nil)
            }
        }
        else {
            print("This device has no support for sourceType photoLibrary")
        }
    }
    
    /** Shows a Media Picker from the Camera */
    open static func showCameraMediaPicker(delegateViewController: UIViewController,
                                           captureMode: UIImagePickerControllerCameraCaptureMode = .photo,
                                           cameraDevice: UIImagePickerControllerCameraDevice = .rear) {
        
        // If the device has support for the asked sourceType
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // If the device has support for the asked cameraDevice
            if UIImagePickerController.isCameraDeviceAvailable(cameraDevice) {
                let pickerController = self.pickerController(delegateViewController: delegateViewController)
                
                pickerController.sourceType = .camera
                pickerController.cameraCaptureMode = captureMode
                pickerController.cameraDevice = cameraDevice
                pickerController.showsCameraControls = true
                
                DispatchQueue.main.async {
                    delegateViewController.present(pickerController, animated: true, completion: nil)
                }
            }
            else {
                print("This device has no support for the chose cameraDevice")
            }
        }
        else {
            print("This device has no support for sourceType camera")
        }
    }
    
    fileprivate static func pickerController(delegateViewController: UIViewController) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = delegateViewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        return pickerController
    }
}
