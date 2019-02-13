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
        heightForHeaderInSection sectionIndex: Int
    ) -> CGFloat {
        let section = sections[sectionIndex]
        
        // If a header view is specified by the section, return the section's header height.
        if section.headerView != nil && section.reusableHeaderViewClass != nil {
            return section.headerHeight
        }
        
        // If no header view is specified by the section, return the default header height.
        return defaultHeaderViewHeight ?? section.headerHeight
    }
    
    open override func tableView(
        _ tableView: UITableView,
        heightForFooterInSection sectionIndex: Int
    ) -> CGFloat {
        let section = sections[sectionIndex]
        
        // If a footer view is specified by the section, return the section's footer height.
        if section.footerView != nil && section.reusableFooterViewClass != nil {
            return section.footerHeight
        }
        
        // If no footer view is specified by the section, return the default footer height.
        return defaultFooterViewHeight ?? section.footerHeight
    }
    
    open override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection sectionIndex: Int
    ) -> UIView? {
        let section = sections[sectionIndex]
        
        // Prefer the specific header view, if there is one.
        if let headerView = section.headerView {
            return headerView
        }
        
        // Next, prefer the header view class, if there is one.
        if let headerClass = section.reusableHeaderViewClass {
            registerHeaderFooterClassIfNeeded(headerClass)
            
            return tableView.dequeueReusableHeaderFooterView(
                withIdentifier: headerClass.reuseIdentifier
            )
        }
        
        // Finally, if there is no header view specified by the section, use the default one, if
        // there is one.
        if let headerClass = defaultHeaderViewClass {
            return tableView.dequeueReusableHeaderFooterView(
                withIdentifier: headerClass.reuseIdentifier
            )
        }
        
        return nil
    }
    
    open override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection sectionIndex: Int
    ) -> UIView? {
        let section = sections[sectionIndex]
        
        // Prefer the specific footer view, if there is one.
        if let footerView = section.footerView {
            return footerView
        }
        
        // Next, prefer the footer view class, if there is one.
        if let footerClass = section.reusableFooterViewClass {
            registerHeaderFooterClassIfNeeded(footerClass)
            
            return tableView.dequeueReusableHeaderFooterView(
                withIdentifier: footerClass.reuseIdentifier
            )
        }
        
        // Finally, if there is no footer view specified by the section, use the default one, if
        // there is one.
        if let footerClass = defaultFooterViewClass {
            return tableView.dequeueReusableHeaderFooterView(
                withIdentifier: footerClass.reuseIdentifier
            )
        }
        
        return nil
    }
    
    open override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if let responder = item(at: indexPath).base as? WillDisplayResponder {
            responder.onWillDisplay?(indexPath)
        }
    }
    
    open override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        if let responder = item(at: indexPath).base as? WillSelectResponder {
            return responder.onWillSelect?(indexPath) ?? indexPath
        }
        
        return indexPath
    }
    
    open override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let responder = item(at: indexPath).base as? DidSelectResponder {
            responder.onDidSelect?(indexPath)
        }
    }
    
    open override func tableView(
        _ tableView: UITableView,
        willDeselectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        if let responder = item(at: indexPath).base as? WillDeselectResponder {
            return responder.onWillDeselect?(indexPath) ?? indexPath
        }
        
        return indexPath
    }
    
    open override func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
    ) {
        if let responder = item(at: indexPath).base as? DidDeselectResponder {
            responder.onDidDeselect?(indexPath)
        }
    }
    
}
