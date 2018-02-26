//
//  VCCollectionViewController.swift
//  FCAlertView
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

open class VCCollectionViewController: UICollectionViewController, RefreshControlManagerDelegate, SearchControlManagerDelegate {
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

    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControlManager.delegate = self
        if self.includesRefreshControl {
            self.refreshControlManager.setupRefreshControl(scrollView: self.collectionView)
        }
        
        self.searchControlManager.delegate = self
        if self.includesSearchControl {
            self.searchControlManager.setupSearchControl(viewController: self)
        }

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
        
        self.collectionView?.backgroundColor = sharedAppearanceManager.appearance.collectionViewBackgroundColor
        
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedAppearanceManager.appearance.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
        
        if !storyboardAppearance {
            self.view.tintColor = sharedAppearanceManager.appearance.viewControllerViewTintColor
            self.view.backgroundColor = sharedAppearanceManager.appearance.collectionViewBackgroundColor
        }
        
        //Updates TabBar colors
        self.tabBarController?.applyAppearance()
    }

    // MARK: - RefreshControlManagerDelegate
    public func refreshControlDidRefresh(manager: RefreshControlManager) {
    }
    
    // MARK: - SearchControlManagerDelegate
    public func searchControlDidBeginEditing(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.collectionView?.bounces = false
            self.collectionView?.alwaysBounceVertical = false
        }
    }
    
    public func searchControlCancelButtonPressed(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.collectionView?.bounces = true
            self.collectionView?.alwaysBounceVertical = true
        }
    }
    
    public func searchControl(manager: SearchControlManager, didSearch text: String?) {
    }
}
