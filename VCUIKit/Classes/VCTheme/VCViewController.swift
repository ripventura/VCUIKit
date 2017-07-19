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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
        sharedAppearanceManager.appearance = defaultAppearance
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    override func applyAppearance() -> Void {
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
    
    @IBOutlet open var tableView : VCTableView?
    
    private var placeholderView : VCView = VCView()
    open var placeHolderImageView : VCImageView = VCImageView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeholderTitleLabel : VCLabel = VCLabel()
    open var placeHolderTextLabel : VCLabel = VCLabel()
    open var placeHolderActionButton : VCButton = VCButton()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateInterface()
        
        self.setupRefreshControl()
        
        self.configureSearchControl()
    }
    
    /** Populates the Interface with its UI Objects */
    private func populateInterface() {
        if self.tableView == nil {
            self.tableView = VCTableView(frame: CGRectDefault, style: .grouped)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            
            self.tableView?.addTo(superView: self.view, withConstraint: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        let centerYOffset = -80
        
        self.view.addSubview(self.placeholderView)
        self.view.sendSubview(toBack: self.placeholderView)
        placeholderView.snp.makeConstraints({make in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-20)
        })
        
        self.placeholderView.addSubview(self.placeHolderImageView)
        placeHolderImageView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeholderView)
            make.bottom.equalTo(self.placeholderView.snp.centerY).offset(centerYOffset)
            make.width.equalTo(100)
            make.height.equalTo(100)
        })
        
        self.placeholderView.addSubview(self.placeHolderActivityIndicatorView)
        self.placeHolderActivityIndicatorView.hidesWhenStopped = true
        placeHolderActivityIndicatorView.snp.makeConstraints({make in
            make.centerX.equalTo(self.placeHolderImageView)
            make.centerY.equalTo(self.placeHolderImageView)
        })
        
        self.placeholderTitleLabel = VCLabel(frame: CGRectDefault)
        self.placeholderTitleLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleColor
        self.placeholderTitleLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTitleFont
        self.placeholderTitleLabel.textAlignment = .center
        self.placeholderTitleLabel.numberOfLines = 0
        self.placeholderView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(self.placeholderView)
            make.right.equalTo(self.placeholderView)
            make.top.equalTo(self.placeholderView.snp.centerY).offset(centerYOffset + 20)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        self.placeholderView.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(self.placeholderView)
            make.right.equalTo(self.placeholderView)
            make.top.equalTo(self.placeholderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        self.placeholderView.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.placeholderActionButtonPressed(_:)), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(self.placeholderView)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
    }
    
    // MARK: - Placeholders
    
    /** Enables / Disables the Placeholder View */
    open func placeholder(enable : Bool,
                          title: String? = nil,
                          text: String? = nil,
                          image: UIImage? = nil,
                          activity: Bool = false,
                          buttonTitle: String? = nil,
                          isButtonHidden: Bool = true) -> Void {
        self.placeholderView.isHidden = !enable
        self.tableView?.isHidden = enable
        
        self.placeholderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderImageView.image = image
        if activity {
            self.placeHolderActivityIndicatorView.startAnimating()
        } else {
            self.placeHolderActivityIndicatorView.stopAnimating()
        }
        self.placeHolderActionButton.setTitle(buttonTitle, for: .normal)
        self.placeHolderActionButton.isHidden = isButtonHidden
    }
    
    /** Called after the placeHolderActionButton is pressed */
    open func placeholderActionButtonPressed(_ sender: Any) -> Void {
        
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
    open func searchControl(enable: Bool) -> Void {
        if enable {
            self.setNavitagionBarTitle(view: searchController.searchBar)
            searchController.searchBar.becomeFirstResponder()
        } else {
            searchController.searchBar.resignFirstResponder()
            self.setNavitagionBarTitle(view: nil)
        }
    }
    
    /** Called after text is typed on the SearchBar */
    open func didSearch(text: String) -> Void {
        
    }
    
    /** Called after the Search is cancelled */
    open func didCancelSearch() -> Void {
        self.searchControl(enable: false)
    }
}
extension VCTabledViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return VCTableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let appearance = (tableView as? VCTableView)?.storyboardAppearance
        return appearance != nil ? (appearance! ? tableView.rowHeight : sharedAppearanceManager.appearance.tableViewCellHeight) : tableView.rowHeight
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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.willSetDefaultStyles()
        self.applyAppearance()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    /** Override this if you want to change the Default Styles for this particular View Controller */
    open func willSetDefaultStyles() {
        sharedAppearanceManager.appearance = defaultAppearance
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    override func applyAppearance() -> Void {
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
