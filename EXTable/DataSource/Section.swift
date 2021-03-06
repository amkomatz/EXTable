//
//  Section.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

/// A section in a table view, expressed as a structure.
///
/// The rows in a section are stored as the `AnyRow` type. Because normal Row objects are generic,
/// they cannot be simply stored in a normal array. Therefore, they are kept in the `AnyRow` "box"
/// until they are used. At this point, they must be casted to the specified type.
public struct Section {
    
    public var id: String?
    
    /// The rows in the section.
    public var rows: [AnyRow] = []
    
    public var headerTitle: String? = nil
    public var estimatedHeaderHeight: CGFloat = UITableView.automaticDimension
    public var headerHeight: CGFloat = UITableView.automaticDimension
    /// The header view to be displayed for the section.
    public var headerView: UIView? = nil
    /// The reusable header view to be dequeued if `headerView` is nil.
    public var reusableHeaderViewClass: (UITableViewHeaderFooterView & Reusable).Type? = nil
    
    public var footerTitle: String? = nil
    public var estimatedFooterHeight: CGFloat = UITableView.automaticDimension
    public var footerHeight: CGFloat = UITableView.automaticDimension
    /// The footer view to be displayed for the section.
    public var footerView: UIView? = nil
    /// The reusable footer view to be dequeued if `footerView` is nil.
    public var reusableFooterViewClass: (UITableViewHeaderFooterView & Reusable).Type? = nil
    
    /// The number of rows in the section.
    public var rowCount: Int { return rows.count }
    
    public init() {}
    
    public init(id: String, headerTitle: String? = nil) {
        self.id = id
        self.headerTitle = headerTitle
    }
    
    public init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
    /// Appends a row to the end of the section.
    ///
    /// - Parameter newRow: The row to be appended to the section.
    public mutating func appendRow<T: Row>(_ newRow: T) {
        rows.append(newRow)
    }
    
    /// Inserts a row into the section at the specified index.
    ///
    /// - Parameters:
    ///   - newRow: The row to be added to the section.
    ///   - index: The index to insert the row into.
    public mutating func insertRow(_ newRow: AnyRow, at index: Int) {
        rows.insert(newRow, at: index)
    }
    
    /// Inserts a row into the section at the specified index.
    ///
    /// - Parameters:
    ///   - newRow: The row to be added to the section.
    ///   - index: The index to insert the row into.
    public mutating func insertRow<T: Row>(_ newRow: T, at index: Int) {
        rows.insert(AnyRow(newRow), at: index)
    }
    
    /// Inserts new rows into the section at the specified index.
    ///
    /// - Parameters:
    ///   - rows: The rows to be added to the section.
    ///   - index: The index to insert the rows into.
    public mutating func insertRows<T: Row>(_ rows: [T], at index: Int) {
        let rows = rows.map { AnyRow($0) }
        insertRows(rows, at: index)
    }
    
    /// Inserts new rows into the section at the specified index.
    ///
    /// - Parameters:
    ///   - rows: The rows to be added to the section.
    ///   - index: The index to insert the rows into.
    public mutating func insertRows(_ rows: [AnyRow], at index: Int) {
        self.rows.insert(contentsOf: rows, at: index)
    }
    
    /// Removes the row at the specified index.
    ///
    /// - Parameter index: The index of the row to be removed.
    public mutating func removeRow(at index: Int) {
        rows.remove(at: index)
    }
    
    /// Returns a configured table view cell for the table view at the specified index path.
    public func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        return rows[indexPath.row].configuredCell(for: tableView, at: indexPath)!
    }
    
    /// Removes the header from the section.
    public mutating func removeHeader() {
        headerTitle = nil
        headerView = UIView()
        headerHeight = CGFloat.leastNonzeroMagnitude
        reusableHeaderViewClass = nil
    }
    
    /// Removes the footer from the section.
    public mutating func removeFooter() {
        footerTitle = nil
        footerView = UIView()
        footerHeight = CGFloat.leastNonzeroMagnitude
        reusableFooterViewClass = nil
    }
    
}
