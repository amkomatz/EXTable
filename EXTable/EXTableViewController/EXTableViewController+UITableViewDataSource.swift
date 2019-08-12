//
//  EXTableViewController+UITableViewDataSource.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

extension EXTableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section].rowCount
    }
    
    open override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        // Register the cell, if needed.
        let cellClass = row.cellClass
        let cellClassName = String(describing: cellClass)
        if registeredCells.contains(cellClassName) == false {
            tableView.register(cellClass.self)
            registeredCells.insert(cellClassName)
        }
        
        let cell = row.configuredCell(for: tableView, at: indexPath)!
        
        if let accessibilityContainer = row as? AccessibilityContaining {
            cell.accessibilityHint = accessibilityContainer.accessibilityHint
            cell.accessibilityLabel = accessibilityContainer.accessibilityLabel
            cell.accessibilityValue = accessibilityContainer.accessibilityValue
            cell.accessibilityIdentifier = accessibilityContainer.accessibilityIdentifier
            
            if let accessibilityTraits = accessibilityContainer.accessibilityTraits {
                cell.accessibilityTraits = accessibilityTraits
            }
        }
        
        return cell
    }
    
}
