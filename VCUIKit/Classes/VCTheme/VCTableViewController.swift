//
//  VCTableViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 20/09/17.
//

import UIKit

@IBDesignable open class VCTableViewController: UITableViewController {
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesRefreshControl: Bool = false
    /** Whether the TableView should have a RefreshControl */
    @IBInspectable open var includesSearchControl: Bool = false
    /** Wheter the appearance is being set manually on Storyboard */
    @IBInspectable open var storyboardAppearance: Bool = false
    
    open var placeHolderImageView : VCImageView = VCImageView()
    open var placeHolderActivityIndicatorView : VCActivityIndicatorView = VCActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    open var placeholderTitleLabel : VCLabel = VCLabel()
    open var placeHolderTextLabel : VCLabel = VCLabel()
    open var placeHolderActionButton : VCButton = VCButton()
    
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // Used on iOS <= 10 to hide rightBarButtonItems when searching
    var rightButtonItems: [UIBarButtonItem]?
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBackButtonStyle()
        
        self.setupPlaceholders()
        self.setupSearchControl()
        self.setupRefreshControl()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.applyAppearance()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 11, *) {
        }
        else {
            self.searchControl(enable: self.includesSearchControl)
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    // MARK: - Placeholders
    
    /** Sets up the placeholders on the tableView.backgroundView */
    private func setupPlaceholders() {
        let centerYOffset = -80
        
        let backgroundView: UIView = UIView(frame: CGRectDefault)
        self.tableView.backgroundView = backgroundView
        
        backgroundView.addSubview(self.placeHolderImageView)
        placeHolderImageView.snp.makeConstraints({make in
            make.centerX.equalTo(backgroundView)
            make.bottom.equalTo(backgroundView.snp.centerY).offset(centerYOffset)
            make.width.equalTo(100)
            make.height.equalTo(100)
        })
        
        backgroundView.addSubview(self.placeHolderActivityIndicatorView)
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
        backgroundView.addSubview(self.placeholderTitleLabel)
        placeholderTitleLabel.snp.makeConstraints({make in
            make.left.equalTo(backgroundView)
            make.right.equalTo(backgroundView)
            make.top.equalTo(backgroundView.snp.centerY).offset(centerYOffset + 20)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderTextLabel = VCLabel(frame: CGRectDefault)
        self.placeHolderTextLabel.textColor = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextColor
        self.placeHolderTextLabel.font = sharedAppearanceManager.appearance.tabledViewControllerPlaceholderTextFont
        self.placeHolderTextLabel.textAlignment = .center
        self.placeHolderTextLabel.numberOfLines = 0
        backgroundView.addSubview(self.placeHolderTextLabel)
        placeHolderTextLabel.snp.makeConstraints({make in
            make.left.equalTo(backgroundView)
            make.right.equalTo(backgroundView)
            make.top.equalTo(self.placeholderTitleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(40)
        })
        
        self.placeHolderActionButton = VCButton(frame: CGRectDefault)
        backgroundView.addSubview(self.placeHolderActionButton)
        self.placeHolderActionButton.addTarget(self, action: #selector(self.placeholderActionButtonPressed(_:)), for: .touchUpInside)
        placeHolderActionButton.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(self.placeHolderTextLabel.snp.bottom).offset(8)
        })
    }
    
    /** Updates the placeholders */
    open func updatePlaceholders(enable: Bool,
                                 title: String? = nil,
                                 text: String? = nil,
                                 image: UIImage? = nil,
                                 activity: Bool = false,
                                 buttonTitle: String? = nil) -> Void {
        self.tableView.separatorStyle = enable ? .none : .singleLine
        
        if enable {
            self.tableView.bringSubview(toFront: self.tableView.backgroundView!)
        }
        else {
            self.tableView.sendSubview(toBack: self.tableView.backgroundView!)
        }
        
        self.placeholderTitleLabel.text = title
        self.placeHolderTextLabel.text = text
        self.placeHolderImageView.image = image
        if activity {
            self.placeHolderActivityIndicatorView.startAnimating()
        } else {
            self.placeHolderActivityIndicatorView.stopAnimating()
        }
        self.placeHolderActionButton.setTitle(buttonTitle, for: .normal)
        self.placeHolderActionButton.isHidden = buttonTitle == nil
    }
    
    /** Called after the placeHolderActionButton is pressed */
    @objc open func placeholderActionButtonPressed(_ sender: Any) -> Void {
        
    }
    
    // MARK: - Refresh Control
    
    internal func setupRefreshControl() -> Void {
        if self.includesRefreshControl {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.addTarget(self, action: #selector(self.refreshControlTriggered), for: .valueChanged)
        }
    }
    @objc fileprivate func refreshControlTriggered() {
        if self.refreshControl!.isRefreshing {
            self.didRefreshControl()
        }
    }
    /** Called after the RefreshControl is triggered */
    open func didRefreshControl() -> Void {
    }
    
    // MARK: - Search Control
    
    /** Sets up the SearchControl. Override this calling super for any custom properties. */
    open func setupSearchControl() -> Void {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        // Good practice
        definesPresentationContext = false
        
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = true
            
            self.searchControl(enable: self.includesSearchControl)
        }
        else {
            searchController.hidesNavigationBarDuringPresentation = false
        }
    }
    
    /** Enables / disables the SearchControl */
    open func searchControl(enable: Bool) {
        if enable {
            if #available(iOS 11.0, *) {
                self.navigationItem.searchController = self.searchController
            } else {
                if self.navigationItem.titleView != searchController.searchBar {
                    // Fallback on earlier versions
                    self.setNavitagionBarTitle(view: searchController.searchBar)
                }
            }
        }
        else {
            self.searchController.searchBar.resignFirstResponder()
            
            if #available(iOS 11.0, *) {
                self.navigationItem.searchController = nil
            } else {
                // Fallback on earlier versions
                self.setNavitagionBarTitle(view: nil)
            }
        }
    }
    
    /** Called after the SearchControl updates it's text */
    open func didSearch(text: String?) {
        
    }
    
    // MARK: - Data Loading
    
    /** Reloads TableView Data */
    open func reloadData() {
        self.tableView?.reloadData()
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
        
        if #available(iOS 11.0, *) {
            if self.includesSearchControl {
                self.refreshControl?.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
            }
            if self.includesRefreshControl {
                // This is needed to fix a bug on iOS 11 where refreshControls brake when refreshing
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
        
        searchController.searchBar.tintColor = sharedAppearanceManager.appearance.navigationBarTintColor
        
        if !storyboardAppearance {
            self.view.tintColor = sharedAppearanceManager.appearance.viewControllerViewTintColor
            self.view.backgroundColor = sharedAppearanceManager.appearance.viewControllerViewBackgroundColor
        }
        
        //Updates TabBar colors
        self.tabBarController?.applyAppearance()
    }
}
extension VCTableViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension VCTableViewController: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.didSearch(text: searchController.searchBar.text)
    }
}
extension VCTableViewController: UISearchBarDelegate {
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
            self.rightButtonItems = self.navigationItem.rightBarButtonItems
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if #available(iOS 11.0, *) {
        }
        else {
            self.navigationItem.rightBarButtonItems = self.rightButtonItems
            self.rightButtonItems = nil
        }
    }
}

extension VCTableViewController {
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

