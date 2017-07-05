//
//  ViewController.swift
//  VCUIKit
//
//  Created by ripventura on 05/26/2017.
//  Copyright (c) 2017 ripventura. All rights reserved.
//

import UIKit
import VCUIKit

class DemoViewController: VCTableViewController, VCCodeScannerProtocol {
    
    var codeScannerViewController : VCCodeScannerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "VCCodeScannerIdentifier" {
            self.codeScannerViewController = segue.destination as? VCCodeScannerViewController
            self.codeScannerViewController?.delegate = self
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
                VCActionSheetPicker.showStringPicker(title: "Picking Strings",
                                                     stringOptions: ["Dog", "Cat", "Bird", "Turtle"],
                                                     initialSelection: 2,
                                                     originView: self.view,
                                                     completionHandler: {index, value in
                                                        print("You selected " + value + " at index " + String(format: "%d", index))
                },
                                                     cancelHandler: {
                                                        print("String picker has been canceled")
                })
            case 2:
                VCActionSheetPicker.showDatePicker(title: "Picking Dates",
                                                   pickerMode: .date,
                                                   selectedDate: Date(),
                                                   minimumDate: Date().addingTimeInterval(-25920000),
                                                   maximumDate: Date().addingTimeInterval(25920000),
                                                   originView: self.view,
                                                   completionHandler: {date in
                                                    print("You selected " + date.description)
                },
                                                   cancelHandler: {
                                                    print("Date picker has been canceled")
                })
            case 3:
                VCMediaPicker.showMediaPicker(maxSelections: 2,
                                              mediaKind: .photo,
                                              mediaSource: .both,
                                              parentViewController: self,
                                              completionHandler: { images in
                                                print("You selected " + images.description)
                })
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                VCAlertView.showAlert(style: .Success,
                                           title: "Success!",
                                           message: "This is a success message",
                                           iconImage: nil,
                                           doneButton: VCAlertView.AlertButton.init(title: "Roger that!", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 1:
                VCAlertView.showAlert(style: .Error,
                                           title: "Error",
                                           message: "This is an error message",
                                           iconImage: nil,
                                           doneButton: VCAlertView.AlertButton.init(title: "Oh dear :(", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 2:
                VCAlertView.showAlert(style: .Warning,
                                           title: "Warning!",
                                           message: "This is a warning message",
                                           iconImage: nil,
                                           doneButton: VCAlertView.AlertButton.init(title: "Jeez...", handler: {print("Dismiss button pressed")}),
                                           buttons: [])
            case 3:
                VCAlertView.showAlert(message: "This is a normal message")
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                sharedBannerCreator.showBanner(theme: .success,
                                                        message: "Success message")
            case 1:
                sharedBannerCreator.showBanner(theme: .error,
                                                        message: "Error message")
            case 2:
                sharedBannerCreator.showBanner(theme: .info,
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
                sharedHUD.show(progress: nil, message: "Loading indeterminate")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4, execute: {
                    sharedHUD.dismiss(completion: nil)
                })
            case 1:
                sharedHUD.show(progress: 0.0,
                               message: "Loading with progress")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    sharedHUD.update(progress: 0.50)
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                        sharedHUD.update(progress: 0.75)
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            sharedHUD.update(progress: 1.0)
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5, execute: {
                                sharedHUD.show(context: .success, message: "Finished loading :D")
                            })
                        })
                    })
                })
            case 2:
                sharedHUD.show(context: .success, message: "Success!")
            case 3:
                sharedHUD.show(context: .error, message: "Error :(")
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
}



