//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCViewController: UIViewController {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable open var storyboardAppearance: Bool = false
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
        sharedStyleManager = VCThemeDefaultStyles()
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    override func applyAppearance() -> Void {
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedStyleManager.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
    
        if !storyboardAppearance {
            self.view.tintColor = sharedStyleManager.viewControllerViewTintColor
            self.view.backgroundColor = sharedStyleManager.viewControllerViewBackgroundColor
        }
        
        //Updates TabBar colors
        self.tabBarController?.applyAppearance()
        
        //Doesn't let the subvies extend through the NavigationBar / TabBar
        self.edgesForExtendedLayout = []
    }
}
extension VCViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/**
 VCViewController simulating a UITableViewController.
 This allows you to use a view normally as you would on a regular ViewController,
 instead of having a UITableView directly as subview.*/
open class VCTabledViewController: VCViewController {
    
    @IBOutlet weak var tableView : VCTableView?
    
    //BackgroundView is hidden by default
    var backgroundView : UIView = UIView()
    var placeHolderImageView : UIImageView = UIImageView()
    var placeholderTitleLabel : UILabel = UILabel()
    var placeHolderTextLabel : UILabel = UILabel()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateInterface()
    }
    
    //Switches the hidden state between Background View and TableView
    func setHiddenPlaceholder(hidden : Bool) -> Void {
        self.backgroundView.isHidden = hidden
        self.tableView?.backgroundColor = hidden ? sharedStyleManager.viewControllerViewBackgroundColor : .clear
    }
    
    /** Populates the Interface with its UI Objects */
    private func populateInterface() {
        if self.tableView == nil {
            self.tableView = VCTableView()
            self.tableView?.delegate = self
            self.tableView?.addToSuperViewWithConstraints(superview: self.view,
                                                          constraintInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
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
        
        self.placeholderTitleLabel = UILabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = sharedStyleManager.tabledViewControllerPlaceholderTitleColor
        self.placeholderTitleLabel.font = sharedStyleManager.tabledViewControllerPlaceholderTitleFont
        self.placeholderTitleLabel.textAlignment = .center
        self.backgroundView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView).offset(20)
            make.right.equalTo(self.backgroundView).offset(-20)
            make.top.equalTo(self.backgroundView.snp.centerY)
            make.height.equalTo(32)
        })
        
        self.placeHolderTextLabel = UILabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedStyleManager.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedStyleManager.tabledViewControllerPlaceholderTextFont
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
}
extension VCTabledViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return VCTableViewCell(style: .default, reuseIdentifier: nil)
    }
}
extension VCTabledViewController: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

open class VCTableViewController: UITableViewController {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable open var storyboardAppearance: Bool = false
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    func willSetDefaultStyles() {
        sharedStyleManager = VCThemeDefaultStyles()
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    override func applyAppearance() -> Void {
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedStyleManager.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
        
        if !storyboardAppearance {
            self.view.tintColor = sharedStyleManager.viewControllerViewTintColor
            self.view.backgroundColor = sharedStyleManager.viewControllerViewBackgroundColor
        }
        
        //Updates TabBar colors
        self.tabBarController?.applyAppearance()
        
        //Doesn't let the subvies extend through the NavigationBar / TabBar
        self.edgesForExtendedLayout = []
    }
}
extension VCTableViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
