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
    
    open override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
        ) {
        if let responder = responder(at: indexPath) {
            responder.onWillDisplay?(indexPath)
        }
    }
    
    open override func tableView(
        _ tableView: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath
        ) {
        if let responder = responder(at: indexPath) {
            responder.onDidDisplay?(indexPath)
        }
    }
    
    open override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
        ) -> IndexPath? {
        if let responder = responder(at: indexPath) {
            return responder.onWillSelect?(indexPath) ?? indexPath
        }
        
        return indexPath
    }
    
    open override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
        ) {
        if let responder = responder(at: indexPath) {
            responder.onDidSelect?(indexPath)
        }
    }
    
    open override func tableView(
        _ tableView: UITableView,
        willDeselectRowAt indexPath: IndexPath
        ) -> IndexPath? {
        if let responder = responder(at: indexPath) {
            return responder.onWillDeselect?(indexPath) ?? indexPath
        }
        
        return indexPath
    }
    
    open override func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
        ) {
        if let responder = responder(at: indexPath) {
            responder.onDidDeselect?(indexPath)
        }
    }
    
    private func responder(at indexPath: IndexPath) -> RowResponder? {
        return item(at: indexPath).base as? RowResponder
    }
    
}
