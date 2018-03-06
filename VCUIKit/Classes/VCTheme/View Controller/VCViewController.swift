//
//  View Controllers.swift
//  VCLibrary
//
//  Created by Vitor Cesco on 6/2/16.
//  Copyright © 2016 Vitor Cesco. All rights reserved.
//

import UIKit

open class VCViewController: UIViewController, RefreshControlManagerDelegate, SearchControlManagerDelegate {
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    /** Whether the CollectionView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the CollectionView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Whether the CollectionView should disable the RefreshControl when searching */
    @IBInspectable open var disablesRefreshWhenSearching: Bool = true
    
    open var refreshControlManager: RefreshControlManager = RefreshControlManager()
    open var searchControlManager: SearchControlManager = SearchControlManager()
    
    @IBOutlet open var placeholderView: VCPlaceholderView?
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
        
        self.refreshControlManager.delegate = self
        
        self.searchControlManager.delegate = self
        if self.includesSearchControl {
            self.searchControlManager.setupSearchControl(viewController: self)
        }
        
        self.setupPlaceholders()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.applyAppearance()
    }
    
    // MARK: - Placeholders
    /** Sets up the placeholders */
    private func setupPlaceholders() {
        if self.placeholderView == nil {
            placeholderView = VCPlaceholderView(frame: CGRectDefault)
            self.view.addSubview(placeholderView!)
            self.view.sendSubview(toBack: placeholderView!)
            placeholderView!.snp.makeConstraints({make in
                make.edges.equalToSuperview()
            })
        }
        placeholderView!.setup(actionHandler: {
            self.placeholderActionButtonPressed()
        })
    }
    
    /** Update ths PlaceholderView */
    open func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 drawer: VCDrawerProtocol? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) {
        self.placeholderView?.update(enable: enable,
                                     title: title,
                                     text: text,
                                     drawer: drawer,
                                     activity: activity,
                                     buttonTitle: buttonTitle)
    }
    
    /** Called after the placeHolderActionButton is pressed */
    open func placeholderActionButtonPressed() {
        
    }
    
    // MARK: - RefreshControlManagerDelegate
    open func refreshControlDidRefresh(manager: RefreshControlManager) {
    }
    
    // MARK: - SearchControlManagerDelegate
    open func searchControlDidBeginEditing(manager: SearchControlManager) {
    }
    open func searchControlCancelButtonPressed(manager: SearchControlManager) {
    }
    open func searchControl(manager: SearchControlManager, didSearch text: String?) {
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
        
        self.searchControlManager.searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        self.placeholderView?.applyAppearance()
    }
}
extension VCViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

