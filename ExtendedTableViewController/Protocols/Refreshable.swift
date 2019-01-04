//
//  Refreshable.swift
//  CustomUIKit
//
//  Created by Austin-Michael Komatz on 10/8/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation
import UIKit

/// Protocol giving conforming types the ability to be refreshed.
///
/// The default implementation for refreshIfNeeded() should be left alone, as it only calls
/// refresh() if the refresher is refreshing.
///
/// # Refreshing
/// Any actual refreshing functionality should be placed in the refresh() method.
///
/// # UITableViewControllers
///
/// ## Setup
/// For UITableViewControllers, setupRefresher() also has a default implementation, which adds the
/// refresher to the table view. This method should be called in `viewDidLoad()`.
///
/// ## Refreshing
/// To execute a
/// refresh, simply call `refreshIfNeeded()` in `scrollViewWillBeginDecelerating(_:)`,
/// `scrollViewDidEndDecelerating(_:)`, or anywhere else. As long as the refresher is refreshing
/// when the method `refreshIfNeeded()` is called, the `refresh()` method will be called.
public protocol Refreshable: class {
    
    /// The refresh control view that should be used for refreshing.
    var refresher: UIRefreshControl { get }
    
    func setupRefresher()
    func refreshIfNeeded()
    func refresh()
    
}

public extension Refreshable {
    
    func refreshIfNeeded() {
        if refresher.isRefreshing {
            refresh()
        }
    }
    
}

public extension Refreshable where Self: UITableViewController {
    
    func setupRefresher() {
        refresher.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        tableView.refreshControl = refresher
        tableView.addSubview(refresher)
    }
    
}

public extension Refreshable where Self: UICollectionViewController {
    
    func setupRefresher() {
        refresher.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        collectionView?.refreshControl = refresher
        collectionView?.insertSubview(refresher, at: 0)
    }
    
}
