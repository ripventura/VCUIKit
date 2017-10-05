//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 27/09/17.
//

import UIKit

open class VCTableViewController: UITableViewController {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.applyAppearance()
    }
    
    // MARK: - Styling
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
        sharedAppearanceManager.initializeDefaultAppearance?()
        sharedAppearanceManager.appearance = defaultAppearance
    }
    
    override open func applyAppearance() -> Void {
        self.willSetDefaultStyles()
        super.applyAppearance()
        
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedAppearanceManager.appearance.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
        
        if !storyboardAppearance {
            self.view.tintColor = sharedAppearanceManager.appearance.viewControllerViewTintColor
            self.view.backgroundColor = sharedAppearanceManager.appearance.viewControllerViewBackgroundColor
        }
        
        //Updates TabBar colors
        self.tabBarController?.applyAppearance()
    }
}
extension VCTableViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

