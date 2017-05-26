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
    
    //Video currently not supported (completionHandler implications)
    /*enum MediaKind : Int {
        case Photo, Video, All
    }*/
    public enum MediaKind : Int {
        case Photo
    }
    
    public enum MediaSource : Int {
        case Camera, Library, Both
    }
    
    let pickerController : DKImagePickerController
    
    public init(maxSelections : Int, withMediaKind mediaKind : MediaKind, withMediaSource mediaSource : MediaSource, withCompletionnHandler completionHandler : @escaping ([UIImage]) ->Void) {
        
        self.pickerController = DKImagePickerController()
        
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
    }
    
    public func showAnimated(animated : Bool, parentViewController : UIViewController) {
        parentViewController.present(pickerController, animated: animated, completion: nil)
    }
}
