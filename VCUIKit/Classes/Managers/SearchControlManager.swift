//
//  SearchControlManager.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

public protocol SearchControlManagerDelegate {
    func searchControlDidBeginEditing(manager: SearchControlManager)
    func searchControlCancelButtonPressed(manager: SearchControlManager)
    func searchControl(manager: SearchControlManager, didSearch text: String?)
}

open class SearchControlManager: NSObject {
    private var viewController: UIViewController?
    // Used on iOS <= 10 to hide rightBarButtonItems when searching
    private var rightButtonItems: [UIBarButtonItem]?

    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    open var delegate: SearchControlManagerDelegate?
    
    /** Sets up the SearchController on the given ViewController */
    open func setupSearchControl(viewController: UIViewController) {
        self.viewController = viewController

        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.showsCancelButton = false
        // Good practice
        viewController.definesPresentationContext = false
        
        if #available(iOS 11.0, *) {
            self.viewController?.navigationItem.hidesSearchBarWhenScrolling = true
            
            self.viewController?.navigationItem.searchController = self.searchController
        }
        else {
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.viewController?.setNavitagionBarTitle(view: self.searchController.searchBar)
        }
    }
    
    /** Activates / Deactivates the SearchController */
    func setSearchControl(active: Bool) {
        // If the SearchControl was active and is now being disabled
        if self.searchController.isActive && !active {
            self.didCancelSearch()
        }
        self.searchController.isActive = active
    }

    fileprivate func didCancelSearch() {
        if #available(iOS 11.0, *) {
        }
        else {
            self.viewController?.navigationItem.rightBarButtonItems = self.rightButtonItems
            
            self.rightButtonItems = nil
        }
        self.delegate?.searchControlCancelButtonPressed(manager: self)
    }
}
extension SearchControlManager: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.delegate?.searchControl(manager: self, didSearch: searchController.searchBar.text)
    }
}
extension SearchControlManager: UISearchBarDelegate {
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // This appearance has to be fixed after the bar starts editing (iOS 11 bug)
        if let textField = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if #available(iOS 11.0, *) {
                textField.textColor = sharedAppearanceManager.appearance.navigationBarTitleColor
            }
            else {
                textField.textColor = .darkText
                textField.tintColor = .gray
            }
        }
        
        if #available(iOS 11.0, *) {
        }
        else {
            self.rightButtonItems = self.viewController?.navigationItem.rightBarButtonItems
            self.viewController?.navigationItem.rightBarButtonItems = nil
        }
        self.delegate?.searchControlDidBeginEditing(manager: self)
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didCancelSearch()
    }
}
