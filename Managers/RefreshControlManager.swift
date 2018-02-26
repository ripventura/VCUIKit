//
//  RefreshControlManager.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 26/02/18.
//

import UIKit

public protocol RefreshControlManagerDelegate {
    /** Called after a refresh is triggered */
    func refreshControlDidRefresh(manager: RefreshControlManager)
}

open class RefreshControlManager {
    fileprivate var scrollView: UIScrollView?
    open var delegate: RefreshControlManagerDelegate?

    /** Sets up the RefreshControl on the given UIScrollView */
    open func setupRefreshControl(scrollView: UIScrollView?) {
        self.scrollView = scrollView
        scrollView?.refreshControl = UIRefreshControl()
        scrollView?.refreshControl?.addTarget(self, action: #selector(self.didTriggerRefreshControl), for: .valueChanged)
    }
    @objc fileprivate func didTriggerRefreshControl() {
        if self.scrollView!.refreshControl!.isRefreshing {
            self.delegate?.refreshControlDidRefresh(manager: self)
        }
    }
}
