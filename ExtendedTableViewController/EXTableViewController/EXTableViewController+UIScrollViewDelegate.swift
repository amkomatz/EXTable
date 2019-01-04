//
//  EXTableViewController+UIScrollViewDelegate.swift
//  Leaderboard
//
//  Created by Austin-Michael Komatz on 1/3/19.
//  Copyright © 2019 Cygnet Infotech. All rights reserved.
//

import UIKit

extension EXTableViewController {
    
    open override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if isRefreshingEnabled {
            refreshIfNeeded()
        }
    }
    
}
