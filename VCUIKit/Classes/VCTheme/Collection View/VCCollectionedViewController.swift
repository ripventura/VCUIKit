//
//  VCCollectionedViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

open class VCCollectionedViewController: VCViewController, UICollectionViewDelegate, UICollectionViewDataSource, RefreshControlManagerDelegate, SearchControlManagerDelegate {
    /** Whether the CollectionView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the CollectionView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Whether the CollectionView should disable the RefreshControl when searching */
    @IBInspectable open var disablesRefreshWhenSearching: Bool = true
    
    open var refreshControlManager: RefreshControlManager = RefreshControlManager()
    open var searchControlManager: SearchControlManager = SearchControlManager()
    
    @IBOutlet open var collectionView: UICollectionView?
    
    open var placeholderView: VCPlaceholderView = VCPlaceholderView()

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
        
        self.setupPlaceholders()
    }

    // MARK: - Styling
    override open func applyAppearance() -> Void {
        self.willSetDefaultStyles()
        super.applyAppearance()
        
        self.collectionView?.backgroundColor = sharedAppearanceManager.appearance.collectionViewBackgroundColor
    }

    // MARK: - Placeholders
    /** Sets up the placeholders */
    private func setupPlaceholders() {
        placeholderView = VCPlaceholderView(frame: CGRectDefault)
        self.view.addSubview(placeholderView)
        self.view.sendSubview(toBack: placeholderView)
        placeholderView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        placeholderView.setup(actionHandler: {
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
        self.collectionView?.refreshControl?.endRefreshing()
        
        self.collectionView?.isHidden = enable
        
        self.placeholderView.update(enable: enable,
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
        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.collectionView?.bounces = false
            self.collectionView?.alwaysBounceVertical = false
        }
    }
    
    open func searchControlCancelButtonPressed(manager: SearchControlManager) {
        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.collectionView?.bounces = true
            self.collectionView?.alwaysBounceVertical = true
        }
    }
    
    open func searchControl(manager: SearchControlManager, didSearch text: String?) {
    }

    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: CGRect.zero)
    }
}
