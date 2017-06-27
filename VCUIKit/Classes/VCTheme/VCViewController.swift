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
    @IBInspectable var storyboardAppearance: Bool = false
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    override func applyAppearance() -> Void {
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedAppearanceManager.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
    
        if !storyboardAppearance {
            self.view.tintColor = sharedAppearanceManager.viewControllerViewTintColor
            self.view.backgroundColor = sharedAppearanceManager.viewControllerViewBackgroundColor
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
@IBDesignable open class VCTabledViewController: VCViewController {
    /** Wheter the TableView should have a RefreshControl */
    @IBInspectable open var pullToRefresh: Bool = false
    
    open var pullRefreshControl: UIRefreshControl?
    
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet open weak var tableView : VCTableView?
    
    open var backgroundView : UIView = UIView()
    open var placeHolderImageView : UIImageView = UIImageView()
    open var placeholderTitleLabel : UILabel = UILabel()
    open var placeHolderTextLabel : UILabel = UILabel()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateInterface()
        
        self.setupRefreshControl()
        
        self.configureSearchControl()
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
        self.view.sendSubview(toBack: self.backgroundView)
        placeHolderImageView.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView)
            make.right.equalTo(self.backgroundView)
            make.top.equalTo(self.backgroundView)
            make.bottom.equalTo(self.backgroundView.snp.centerY)
        })
        
        self.placeholderTitleLabel = UILabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = sharedAppearanceManager.tabledViewControllerPlaceholderTitleColor
        self.placeholderTitleLabel.font = sharedAppearanceManager.tabledViewControllerPlaceholderTitleFont
        self.placeholderTitleLabel.textAlignment = .center
        self.backgroundView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self.backgroundView).offset(20)
            make.right.equalTo(self.backgroundView).offset(-20)
            make.top.equalTo(self.backgroundView.snp.centerY)
            make.height.equalTo(32)
        })
        
        self.placeHolderTextLabel = UILabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.tabledViewControllerPlaceholderTextFont
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
    
    // MARK: - Placeholders
    
    //Switches the hidden state between Background View and TableView
    open func setHiddenPlaceholder(hidden : Bool) -> Void {
        self.backgroundView.isHidden = hidden
        self.tableView?.backgroundColor = hidden ? sharedAppearanceManager.viewControllerViewBackgroundColor : .clear
    }
    
    // MARK: - Refresh Control
    
    internal func setupRefreshControl() -> Void {
        if self.pullToRefresh {
            self.pullRefreshControl = UIRefreshControl()
            self.pullRefreshControl?.addTarget(self, action: #selector(self.didPullRefreshControl), for: .valueChanged)
            self.tableView?.addSubview(self.pullRefreshControl!)
        }
    }
    
    /** Called after the PullRefreshControl is triggered */
    open func didPullRefreshControl() -> Void {
    }
    
    // MARK: - Search Control
    
    /** Configures the SearchControl. Override this calling super for any custom properties. */
    open func configureSearchControl() -> Void {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
    }
    
    /** Enables / Disables the Search Control on this ViewController */
    open func updateSearchControl(enable: Bool) -> Void {
        if enable {
            self.setNavitagionBarTitleView(view: searchController.searchBar)
            searchController.searchBar.becomeFirstResponder()
        } else {
            searchController.searchBar.resignFirstResponder()
            self.setNavitagionBarTitleView(view: nil)
        }
    }
    
    /** Called after text is typed on the SearchBar */
    open func didSearch(text: String) -> Void {
        
    }
    
    /** Called after the Search is cancelled */
    open func didCancelSearch() -> Void {
        self.updateSearchControl(enable: false)
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
extension VCTabledViewController: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.didSearch(text: searchController.searchBar.text!)
    }
}
extension VCTabledViewController: UISearchBarDelegate {
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didCancelSearch()
    }
}

@IBDesignable open class VCTableViewController: UITableViewController {
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable var storyboardAppearance: Bool = false
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.updateBackButtonStyle()
    }
    
    override func applyAppearance() -> Void {
        //Updates StatusBar Style
        UIApplication.shared.statusBarStyle = sharedAppearanceManager.applicationStatusBarStyle
        
        //Updates NavigationBar appearance
        self.navigationController?.applyAppearance()
        
        if !storyboardAppearance {
            self.view.tintColor = sharedAppearanceManager.viewControllerViewTintColor
            self.view.backgroundColor = sharedAppearanceManager.viewControllerViewBackgroundColor
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
