//
//  ViewController.swift
//  VCUIKit
//
//  Created by ripventura on 05/26/2017.
//  Copyright (c) 2017 ripventura. All rights reserved.
//

import UIKit
import VCUIKit

class DemoViewController: VCTableViewController, VCCodeScannerDelegate {
    
    var codeScannerViewController : VCCodeScannerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                VCCodeScanner.showScanner(parentViewController: self,
                                          delegate: self)
            case 1:
                VCMediaPicker.showAlbumMediaPicker(delegateViewController: self)
            case 2:
                VCMediaPicker.showCameraMediaPicker(delegateViewController: self)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                VCAlertView.showAlert(style: .success,
                                      title: "Success!",
                                      message: "This is a success message")
            case 1:
                VCAlertView.showAlert(style: .error,
                                      title: "Error!",
                                      message: "This is an error message")
            case 2:
                VCAlertView.showAlert(style: .warning,
                                      title: "Warning!",
                                      message: "This is a warning message",
                                      defaultButton: .init(title: "Logout", handler: {}),
                                      extraButtons: [.init(title: "Cancel", handler: {})])
            case 3:
                VCAlertView.showAlert(message: "This is a normal message")
            case 4:
                VCAlertView.showAlert(message: "This is a custom icon",
                                      icon: VCAlertView.AlertIcon(image: UIImage(named: "VCAlertView Cusom Icon Image")))
            case 5:
                VCAlertView.showAlert(message: "This is a TextField example",
                                      textFields: [
                                        VCAlertView.AlertTextfield(placeholder: "Feedback", didReturn: {text in
                                            sharedBannerCreator.showBanner(theme: .info, message: "Your feedback: " + (text != nil ? text! : ""))
                                        })])
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
                sharedBannerCreator.showBanner(theme: .warning,
                                               message: "Warning message")
            case 4:
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
    
    // MARK: - VCCodeScannerDelegate
    
    func scanner(scanner: VCCodeScannerViewController, didFinnishScanningWithResult result: String) {
        print(result)
    }
    func scannerDidFailScanning(scanner: VCCodeScannerViewController) {
        print("Failed Scanning")
    }
}



