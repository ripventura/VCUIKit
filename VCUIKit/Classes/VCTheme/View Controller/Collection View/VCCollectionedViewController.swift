//
//  VCCollectionedViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

open class VCCollectionedViewController: VCViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet open var collectionView: UICollectionView?

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.includesRefreshControl {
            self.refreshControlManager.setupRefreshControl(scrollView: self.collectionView)
        }
    }

    // MARK: - Data Loading
    /** Reloads CollectionView Data */
    open func reloadData() {
        self.collectionView?.reloadData()
    }
    
    // MARK: - Placeholders
    open override func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 drawer: VCDrawerProtocol? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) {
        self.collectionView?.refreshControl?.endRefreshing()
        
        self.collectionView?.isHidden = enable
        
        super.updatePlaceholders(enable: enable,
                                 title: title,
                                 text: text,
                                 drawer: drawer,
                                 activity: activity,
                                 buttonTitle: title)
    }
    
    // MARK: - SearchControlManagerDelegate
    open override func searchControlDidBeginEditing(manager: SearchControlManager) {
        super.searchControlDidBeginEditing(manager: manager)

        if self.disablesRefreshWhenSearching {
            // Disables the RefreshControl when searching
            self.collectionView?.bounces = false
            self.collectionView?.alwaysBounceVertical = false
        }
    }
    open override func searchControlCancelButtonPressed(manager: SearchControlManager) {
        super.searchControlCancelButtonPressed(manager: manager)

        if self.disablesRefreshWhenSearching {
            // Enables back the RefreshControl
            self.collectionView?.bounces = true
            self.collectionView?.alwaysBounceVertical = true
        }
    }
    
    // MARK: - Styling
    override open func applyAppearance() -> Void {
        super.applyAppearance()

        self.collectionView?.backgroundColor = sharedAppearanceManager.appearance.collectionViewBackgroundColor
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
