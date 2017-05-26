//
//  ViewController.swift
//  VCUIKit
//
//  Created by ripventura on 05/26/2017.
//  Copyright (c) 2017 ripventura. All rights reserved.
//

import UIKit
import VCUIKit

class DemoViewController: VCTableViewController, VCCodeScannerProtocol, VCSignaturePickerViewControllerDelegate {
    
    var codeScannerViewController : VCCodeScannerViewController?
    var signaturePickerViewController : VCSignaturePickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCCodeScannerIdentifier" {
            self.codeScannerViewController = segue.destination as? VCCodeScannerViewController
            self.codeScannerViewController?.delegate = self
        }
        else if segue.identifier == "VCSignaturePickerIdentifier" {
            self.signaturePickerViewController = segue.destination as? VCSignaturePickerViewController
            self.signaturePickerViewController?.delegate = self
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: "VCCodeScannerIdentifier", sender: nil)
            case 1:
                let stringPicker = VCActionSheetPicker()
                stringPicker.showStringPicker(title: "Picking Strings",
                                              stringOptions: ["Dog", "Cat", "Bird", "Turtle"],
                                              initialSelection: 2,
                                              originView: self.view,
                                              completionHandler:
                    {index, value in
                        print("You selected " + value + " at index " + String(format: "%d", index))
                },
                                              cancelHandler:
                    {
                        print("String picker has been canceled")
                })
            case 2:
                let datePicker = VCActionSheetPicker()
                datePicker.showDatePicker(title: "Picking Dates",
                                          pickerMode: .date,
                                          selectedDate: Date(),
                                          minimumDate: Date().addingTimeInterval(-25920000),
                                          maximumDate: Date().addingTimeInterval(25920000),
                                          originView: self.view,
                                          completionHandler:
                    {date in
                        print("You selected " + date.description)
                },
                                          cancelHandler:
                    {
                        print("Date picker has been canceled")
                })
            case 3:
                let mediaPicker = VCMediaPicker(maxSelections: 2,
                                                withMediaKind: .Photo,
                                                withMediaSource: .Both,
                                                withCompletionnHandler:
                    { images in
                        print("You selected " + images.description)
                })
                mediaPicker.showAnimated(animated: true, parentViewController: self)
            case 4:
                self.performSegue(withIdentifier: "VCSignaturePickerIdentifier", sender: nil)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                VCAlertCreator().showAlert(style: .Success,
                                           title: "Success!",
                                           message: "This is a success message",
                                           iconImage: nil,
                                           doneButton: VCAlertCreator.AlertButton.init(title: "Roger that!", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 1:
                VCAlertCreator().showAlert(style: .Error,
                                           title: "Error",
                                           message: "This is an error message",
                                           iconImage: nil,
                                           doneButton: VCAlertCreator.AlertButton.init(title: "Oh dear :(", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 2:
                VCAlertCreator().showAlert(style: .Warning,
                                           title: "Warning!",
                                           message: "This is a warning message",
                                           iconImage: nil,
                                           doneButton: VCAlertCreator.AlertButton.init(title: "Jeez...", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 3:
                VCAlertCreator().showAlert(message: "This is a normal message")
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                sharedBannerCreator.showBannerWithTheme(theme: .success,
                                                        message: "Success message")
            case 1:
                sharedBannerCreator.showBannerWithTheme(theme: .error,
                                                        message: "Error message")
            case 2:
                sharedBannerCreator.showBannerWithTheme(theme: .info,
                                                        message: "Info message")
            case 3:
                let customView = UIView(frame: CGRectDefault)
                customView.backgroundColor = UIColor.purple
                
                sharedBannerCreator.showCustomBanner(contentView: customView,
                                                     duration: 2,
                                                     dismissesOnTap: true,
                                                     dropShadow: true,
                                                     windowDimMode: .none,
                                                     presentationContext: .window(windowLevel: UIWindowLevelNormal),
                                                     presentationDirection: .bottom)
            default:
                break
            }
            
        case 3:
            switch indexPath.row {
            case 0:
                sharedBannerCreator.showStatusBarMessage(theme: .success,
                                                         message: "Success message",
                                                         duration: 2,
                                                         tallBar: false)
            case 1:
                sharedBannerCreator.showStatusBarMessage(theme: .error,
                                                         message: "Error message",
                                                         duration: 2,
                                                         tallBar: false)
            case 2:
                sharedBannerCreator.showStatusBarMessage(theme: .info,
                                                         message: "Info message",
                                                         duration: 2,
                                                         tallBar: false)
            case 3:
                sharedBannerCreator.showStatusBarMessage(message: "Normal message")
            case 4:
                sharedBannerCreator.showStatusBarMessage(theme: .success,
                                                         message: "Tall message",
                                                         duration: 2,
                                                         tallBar: true)
            default:
                break
            }
            
        case 4:
            switch indexPath.row {
            case 0:
                sharedHUDCreator.showHUD(message: "Normal message")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    sharedHUDCreator.hideHUD()
                })
            case 1:
                sharedHUDCreator.showHUD(message: "Cancelable message", hiddenCancel: false, cancelHandler: {
                    print("HUD has been canceled")
                })
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4, execute: {
                    sharedHUDCreator.hideHUD()
                })
            default:
                break
            }
        default:
            break
        }
    }
    
    // MARK: - VCCodeScannerProtocol
    func scanner(scanner: VCCodeScannerViewController, didFinnishScanningWithResult result: String) {
        print(result)
    }
    func scannerDidFailScanning(scanner: VCCodeScannerViewController) {
        print("Failed Scanning")
    }
    
    // MARK: = VCSignaturePickerViewControllerDelegate
    func signaturePickerViewController(controller: VCSignaturePickerViewController, didFinnishSigning isSigned: Bool, withSignedImage signatureImage: UIImage?) {
        print("You " + (isSigned ? "signed with image " + signatureImage!.description : "did not sign anything"))
    }
}



