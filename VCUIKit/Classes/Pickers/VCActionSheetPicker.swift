//
//  VCActionSheetPicker.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 5/24/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

public let defaultActionSheetPicker : VCActionSheetPicker = VCActionSheetPicker()


open class VCActionSheetPicker: NSObject {
    
    //** Shows a String picker with the given options **/
    public func showStringPicker(
        title : String,
        stringOptions : [String],
        initialSelection : Int,
        originView : UIView,
        completionHandler : @escaping (Int, String)->Void,
        cancelHandler : ((Void)->Void)?) {
        
        ActionSheetStringPicker.show(withTitle: title, rows: stringOptions, initialSelection: initialSelection, doneBlock: {
            picker, selectedIndex, selectedValue in
            
            completionHandler(selectedIndex, selectedValue as! String)
            
            }, cancel: { picker in
                if cancelHandler != nil {
                    cancelHandler!()
                }}, origin: originView)
    }
    
    //** Shows a Date picker with the given options **/
    public func showDatePicker(
        title : String,
        pickerMode : UIDatePickerMode,
        selectedDate : Date,
        minimumDate : Date?,
        maximumDate : Date?,
        originView : UIView,
        completionHandler : @escaping (Date)->Void,
        cancelHandler : ((Void)->Void)?) {
        
        
        if minimumDate != nil && maximumDate != nil {
            
            ActionSheetDatePicker.show(withTitle: title, datePickerMode: pickerMode, selectedDate: selectedDate, minimumDate: minimumDate!, maximumDate: maximumDate!, doneBlock: { picker, selectedValue, pickerOrigin in
                
                completionHandler(selectedValue as! Date)
                
                }, cancel: { picker in
                    if cancelHandler != nil {
                        cancelHandler!()
                    }}, origin: originView)
        }
        else {
            ActionSheetDatePicker.show(withTitle: title, datePickerMode: pickerMode, selectedDate: selectedDate, doneBlock: { picker, selectedValue, pickerOrigin in
                
                let finalDate = selectedValue as! Date
                
                completionHandler(finalDate)
                
                }, cancel: { picker in
                    if cancelHandler != nil {
                        cancelHandler!()
                    }}, origin: originView)
        }
    }
}
