//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCViewController: UIViewController, UITextFieldDelegate {
    
    @IBInspectable var viewControllerViewTintColor : UIColor = sharedStyleManager.viewControllerViewTintColor
    @IBInspectable var viewControllerViewBackgroundColor : UIColor = sharedStyleManager.viewControllerViewBackgroundColor
    @IBInspectable var viewControllerStatusBarStyle : UIStatusBarStyle = sharedStyleManager.applicationStatusBarStyle
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyThemeStyle()
    }
    
    
    /** Override this if you want to change the Default Styles for this particular View Controller **/
    func willSetDefaultStyles() {
        sharedStyleManager = VCThemeDefaultStyles()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return sharedStyleManager.defaultInterfaceOrientation
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    
    private func applyThemeStyle() {
        viewControllerViewTintColor = sharedStyleManager.viewControllerViewTintColor
        viewControllerViewBackgroundColor = sharedStyleManager.viewControllerViewBackgroundColor
        viewControllerStatusBarStyle = sharedStyleManager.applicationStatusBarStyle
        
        /** Update NavigationBar colors **/
        self.navigationController?.applyNavigationThemeStyle()
        
        
        /** Update View colors **/
        
        //Updates View tint color
        self.view.tintColor = viewControllerViewTintColor
        
        //Updates View background color
        self.view.backgroundColor = viewControllerViewBackgroundColor
        
        
        /** Update TabBar colors **/
        self.tabBarController?.applyTabBarThemeStyle()
        
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = viewControllerStatusBarStyle
        
        //Doesn't let the subvies extend throug the NavigationBar / TabBar
        self.edgesForExtendedLayout = []
    }
    
    
    /** UITextField Delegate **/
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /** UITextField Delegate **/
}

open class VCTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBInspectable var tableViewCellHeight : CGFloat = sharedStyleManager.tableViewCellHeight
    @IBInspectable var viewControllerViewTintColor : UIColor = sharedStyleManager.viewControllerViewTintColor
    @IBInspectable var viewControllerViewBackgroundColor : UIColor = sharedStyleManager.viewControllerViewBackgroundColor
    @IBInspectable var viewControllerStatusBarStyle : UIStatusBarStyle = sharedStyleManager.applicationStatusBarStyle
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyThemeStyle()
    }
    
    
    /** Override this if you want to change the Default Styles for this particular View Controller **/
    func willSetDefaultStyles() {
        sharedStyleManager = VCThemeDefaultStyles()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return sharedStyleManager.defaultInterfaceOrientation
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    
    private func applyThemeStyle() {
        viewControllerViewTintColor = sharedStyleManager.viewControllerViewTintColor
        viewControllerViewBackgroundColor = sharedStyleManager.viewControllerViewBackgroundColor
        viewControllerStatusBarStyle = sharedStyleManager.applicationStatusBarStyle
        
        /** Update NavigationBar colors **/
        self.navigationController?.applyNavigationThemeStyle()
        
        
        /** Update View colors **/
        
        //Updates View tint color
        self.view.tintColor = viewControllerViewTintColor
        
        //Updates View background color
        self.view.backgroundColor = viewControllerViewBackgroundColor
        
        
        /** Update TabBar colors **/
        self.tabBarController?.applyTabBarThemeStyle()
        
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = viewControllerStatusBarStyle
        
        //Doesn't let the subvies extend throug the NavigationBar / TabBar
        self.edgesForExtendedLayout = []
    }
    
    
    /** UITextField Delegate **/
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /** UITextField Delegate **/
}

/** VCViewController simulating a UITableViewController
 This allows you to use a view normally as you would on a regular ViewController,
 instead of having a UITableView directly as subview. **/
open class VCTabledViewController: VCViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBInspectable var tableViewControllerViewTintColor : UIColor = sharedStyleManager.viewControllerViewTintColor
    @IBInspectable var tableViewControllerViewBackgroundColor : UIColor = sharedStyleManager.viewControllerViewBackgroundColor
    @IBInspectable var tableViewControllerStatusBarStyle : UIStatusBarStyle = sharedStyleManager.applicationStatusBarStyle
    @IBInspectable var tableViewCellHeight : CGFloat = sharedStyleManager.tableViewCellHeight
    
    @IBOutlet weak var tableView : VCTableView!
    
    /* BackgroundView is hidden by default */
    var backgroundView : UIView = UIView()
    var placeHolderImageView : UIImageView = UIImageView()
    var placeholderTitleLabel : VCLabel = VCLabel()
    var placeHolderTextLabel : VCLabel = VCLabel()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if self.tableView == nil {
            self.tableView = VCTableView()
        }
        
        self.populateInterface()
    }
    
    //Switches the hidden state between Background View and TableView
    func setHiddenPlaceholder(hidden : Bool) -> Void {
        self.backgroundView.isHidden = hidden
        self.tableView.backgroundColor = hidden ? self.viewControllerViewBackgroundColor : .clear
    }
    
    /** Populates the Interface with its UI Objects **/
    private func populateInterface() {
        self.view.addSubview(self.backgroundView)
        backgroundView.snp.makeConstraints({make in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(150)
            make.centerY.equalTo(self.view)
        })
        
        self.backgroundView.addSubview(self.placeHolderImageView)
        placeHolderImageView.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView)
            make.right.equalTo(self.backgroundView)
            make.top.equalTo(self.backgroundView)
            make.bottom.equalTo(self.backgroundView.snp.centerY)
        })
        
        self.placeholderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = UIColor.black
        self.placeholderTitleLabel.textAlignment = .center
        self.backgroundView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView).offset(20)
            make.right.equalTo(self.backgroundView).offset(-20)
            make.top.equalTo(self.backgroundView.snp.centerY)
            make.height.equalTo(32)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 2
        self.backgroundView.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView).offset(20)
            make.right.equalTo(self.backgroundView).offset(-20)
            make.top.equalTo(self.placeholderTitleLabel.snp.bottom)
            make.bottom.equalTo(self.backgroundView)
        })
    }
    
    
    /** VCTableViewDelegate **/
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return VCTableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    /** VCTableViewDelegate **/
}
