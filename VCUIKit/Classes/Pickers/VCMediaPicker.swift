//
//  VCMediaPicker.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/23/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import Foundation
import DKImagePickerController

open class VCMediaPicker: NSObject {
    
    
    public enum MediaKind : Int {
        //Video currently not supported (completionHandler implications)
        //case Photo, Video, All
        case photo
    }
    
    public enum MediaSource : Int {
        case camera, library, both
    }
    
    public static func showMediaPicker(maxSelections : Int,
                                       mediaKind : MediaKind,
                                       mediaSource : MediaSource,
                                       parentViewController: UIViewController,
                                       completionHandler : @escaping ([UIImage]) ->Void) {
        
        let pickerController : DKImagePickerController = DKImagePickerController()
        
        pickerController.assetType = DKImagePickerControllerAssetType(rawValue: mediaKind.rawValue)!
        pickerController.maxSelectableCount = maxSelections
        pickerController.sourceType = DKImagePickerControllerSourceType(rawValue: mediaSource.rawValue)!
        
        if maxSelections < 2 {
            pickerController.singleSelect = true
        }
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            var imageArray : [UIImage] = []
            
            for asset in assets {
                asset.fetchOriginalImage(true, completeBlock: {(image: UIImage?, info: [AnyHashable : Any]?) in
                    if image != nil {
                        imageArray.append(image!)
                    }
                })
            }
            
            completionHandler(imageArray)
        }
        
        parentViewController.present(pickerController,
                                     animated: true,
                                     completion: nil)
    }
}
