//
//  EXTableViewController+UITableViewDelegate.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

extension EXTableViewController {
    
    open override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return sections[section].headerTitle
    }
    
    open override func tableView(
        _ tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        return sections[section].footerTitle
    }
    
    open override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return sections[section].headerHeight
    }
    
    open override func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return sections[section].footerHeight
    }
    
    open override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return sections[section].headerView
    }
    
    open override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return sections[section].footerView
    }
    
}
