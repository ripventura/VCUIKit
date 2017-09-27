//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

@IBDesignable open class VCViewController: UIViewController {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.applyAppearance()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    // MARK: - Styling
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
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
extension VCViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
