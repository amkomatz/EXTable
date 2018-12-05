//
//  Section.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

public struct Section {
    
    var rows: [AnyRow] = []
    
    var headerTitle: String? = nil
    var estimatedHeaderHeight: CGFloat = UITableView.automaticDimension
    var headerHeight: CGFloat = UITableView.automaticDimension
    var headerView: UIView? = nil
    
    var footerTitle: String? = nil
    var estimatedFooterHeight: CGFloat = UITableView.automaticDimension
    var footerHeight: CGFloat = UITableView.automaticDimension
    var footerView: UIView? = nil
    
    var rowCount: Int { return rows.count }
    
    public mutating func addRow<T: Row>(_ newRow: T) {
        rows.append(newRow)
    }
    
    public mutating func insertRow(_ newRow: AnyRow, at index: Int) {
        rows.insert(newRow, at: index)
    }
    
    public mutating func insertRow<T: Row>(_ newRow: T, at index: Int) {
        rows.insert(AnyRow(newRow), at: index)
    }
    
    public mutating func removeRow(at index: Int) {
        rows.remove(at: index)
    }
    
    public func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        return rows[indexPath.row].configuredCell(for: tableView, at: indexPath)!
    }
    
    public mutating func removeHeader() {
        headerTitle = nil
        headerView = UIView()
        headerHeight = CGFloat.leastNonzeroMagnitude
    }
    
    public mutating func removeFooter() {
        footerTitle = nil
        footerView = UIView()
        footerHeight = CGFloat.leastNonzeroMagnitude
    }
    
}
