//
//  EXTableViewController.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

/// An extended table view controller with simplified delegate and datasource functionality.
///
/// The main purpose of this class is to simplify the data source and delegate functionality. This
/// is done through the `sections` variable, which holds all of the section/row data. Any data
/// contained in this variable is automatically displayed when `refreshSections` is called. As such,
/// `refreshSections` is the **only** method that should be called in order to reload the table
/// view.
///
/// It is also important to note that this class is not meant to be used as-is, and should be
/// subclassed. When subclassing, the only member that needs to be overridden is `generateSections`.
/// The `cellClasses` property should contain all of the cells that will be used. Registration
/// of cells happens automaticelly. `generateSections` should return all of the data to be
/// displayed.
open class EXTableViewController: UITableViewController {
    
    /// The sections and rows to be displayed in the table view.
    ///
    /// - Important: Whenever this variable is updated, `onSectionUpdate()` is called.
    public private(set) var sections: [Section] = [] {
        didSet {
            onSectionUpdate()
        }
    }
    
    public internal(set) var registeredCells: Set<String> = []
    public internal(set) var registeredHeaderFooterViews: Set<String> = []
    
    /// The header view class that should be used if there isn't one in a section.
    public private(set) var defaultHeaderViewClass: (UITableViewHeaderFooterView & Reusable).Type?
    public private(set) var defaultHeaderViewHeight: CGFloat? = nil
    /// The footer view class that should be used if there isn't one in a section.
    public private(set) var defaultFooterViewClass: (UITableViewHeaderFooterView & Reusable).Type?
    public private(set) var defaultFooterViewHeight: CGFloat? = nil
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        refreshSections()
    }
    
    /// Generates and returns the sections for the table view.
    ///
    /// This method must be overridden for any subclasses. Otherwise, the table view will remain
    /// empty.
    open func generateSections() -> [Section] {
        return []
    }
    
    /// Sets the sections and reloads the table view.
    open func refreshSections() {
        sections = generateSections()
        tableView.reloadData()
    }
    
    /// Sets the default header view class to be used when one isn't provided by a section.
    ///
    /// - Parameters:
    ///   - headerClass: The default header class to be used.
    ///   - height: The default height for the header view.
    public final func setDefaultHeader(
        _ headerClass: (UITableViewHeaderFooterView & Reusable).Type,
        height: CGFloat = UITableView.automaticDimension
    ) {
        registerHeaderFooterClassIfNeeded(headerClass)
        defaultHeaderViewClass = headerClass
        defaultHeaderViewHeight = height
    }
    
    /// Sets the default footer view class to be used when one isn't provided by a section.
    ///
    /// - Parameters:
    ///   - footerClass: The default footer class to be used.
    ///   - height: The default height for the footer view.
    public final func setDefaultFooter(
        _ footerClass: (UITableViewHeaderFooterView & Reusable).Type,
        height: CGFloat = UITableView.automaticDimension
    ) {
        registerHeaderFooterClassIfNeeded(footerClass)
        defaultFooterViewClass = footerClass
        defaultFooterViewHeight = height
    }
    
    public func registerHeaderFooterClassIfNeeded(
        _ headerFooterClass: (UITableViewHeaderFooterView & Reusable).Type
    ) {
        let className = String(describing: headerFooterClass)
        if registeredHeaderFooterViews.contains(className) == false {
            tableView.register(headerFooterClass)
            registeredHeaderFooterViews.insert(className)
        }
    }
    
    
    // MARK: - Observer Methods
    
    /// Called whenever the sections update.
    open func onSectionUpdate() {}
    
    
    // MARK: - Index Path Operations
    
    /// Returns the item at the specified index path.
    ///
    /// - Parameter indexPath: The index path to get the item for.
    /// - Returns: The item at the specified index path.
    open func item(at indexPath: IndexPath) -> AnyRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    /// Returns the first index path where the condition is met, or nil if the condition is never
    /// met.
    ///
    /// - Parameter condition: The condition that must be met.
    /// - Returns: The first index path where the condition is met, or nil if the condition is never
    /// met.
    open func firstIndexPath(where condition: (AnyRow) -> (Bool)) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            if let rowIndex = section.rows.firstIndex(where: condition) {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
        }
        return nil
    }
    
    /// Returns the index path for the specified row, or nil if the row is not in the data source.
    ///
    /// - Parameter row: The row to search for in the data source.
    /// - Returns: The index path for the specified row, or nil if the row is not in the data
    /// source.
    open func indexPath<T: Row>(of row: T) -> IndexPath? {
        return firstIndexPath(where: { anyRow in anyRow == AnyRow(row) })
    }
    
    
    // MARK: - Row Operations
    
    /// Inserts a row into the data source and table view at an index path.
    ///
    /// - Parameters:
    ///   - row: The row to be inserted.
    ///   - indexPath: The index path where the row should be inserted.
    ///   - animation: The animation that should be used when inserting the row.
    open func insertRow<T: Row>(
        _ row: T,
        at indexPath: IndexPath,
        animation: UITableView.RowAnimation = .top
    ) {
        sections[indexPath.section].insertRow(row, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: animation)
    }
    
    /// Inserts rows into the data source and table view at an index path.
    ///
    /// - Parameters:
    ///   - row: The rows to be inserted.
    ///   - indexPath: The index path where the rows should be inserted.
    ///   - animation: The animation that should be used when inserting the rows.
    open func insertRows<T: Row>(
        _ rows: [T],
        at indexPath: IndexPath,
        animation: UITableView.RowAnimation = .top
    ) {
        sections[indexPath.section].insertRows(rows, at: indexPath.row)
        let indexPaths = (0..<rows.count).map { index in
            IndexPath(row: indexPath.row + index, section: indexPath.section)
        }
        tableView.insertRows(at: indexPaths, with: animation)
    }
    
    /// Inserts rows into the data source and table view at an index path.
    ///
    /// - Parameters:
    ///   - row: The rows to be inserted.
    ///   - indexPath: The index path where the rows should be inserted.
    ///   - animation: The animation that should be used when inserting the rows.
    open func insertRows(
        _ rows: [AnyRow],
        at indexPath: IndexPath,
        animation: UITableView.RowAnimation = .top
    ) {
        sections[indexPath.section].insertRows(rows, at: indexPath.row)
        let indexPaths = (0..<rows.count).map { index in
            IndexPath(row: indexPath.row + index, section: indexPath.section)
        }
        tableView.insertRows(at: indexPaths, with: animation)
    }
    
    /// Appends a row to the end of a section.
    ///
    /// - Parameters:
    ///   - row: The row to be appended.
    ///   - section: The index of the section to append the row to.
    ///   - animation: The animation that should be used when appending the row.
    open func appendRow<T: Row>(
        _ row: T,
        to section: Int,
        animation: UITableView.RowAnimation = .top
    ) {
        let indexPath = IndexPath(row: sections[section].rowCount, section: section)
        insertRow(row, at: indexPath, animation: animation)
    }
    
    /// Prepends a row to the beginning of a section.
    ///
    /// - Parameters:
    ///   - row: The row to be prepended.
    ///   - section: The index of the section to prepend the row to.
    ///   - animation: The animation that should be used when prepending the row.
    open func prependRow<T: Row>(
        _ row: T,
        in section: Int,
        animation: UITableView.RowAnimation = .bottom
    ) {
        let indexPath = IndexPath(row: 0, section: section)
        insertRow(row, at: indexPath, animation: animation)
    }
    
    /// Removes the row at a specified index path.
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the row to be removed.
    ///   - animation: The animation that should be used to remove the row.
    ///   - removeSectionIfEmpty: Should the section be removed if it is empty?
    open func removeRow(
        at indexPath: IndexPath,
        animation: UITableView.RowAnimation = .left,
        removeSectionIfEmpty: Bool = true
    ) {
        tableView.performBatchUpdates({
            // Remove the row.
            sections[indexPath.section].removeRow(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: animation)
            
            // Remove the section, if needed.
            if sections[indexPath.section].rowCount == 0 && removeSectionIfEmpty {
                removeSection(at: indexPath.section)
            }
        })
    }
    
    
    /// Removes the rows at a specified index paths.
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the row to be removed.
    ///   - animation: The animation that should be used to remove the row.
    ///   - removeSectionsIfEmpty: Should the sections be removed if empty?
    open func removeRows(
        at indexPaths: [IndexPath],
        animation: UITableView.RowAnimation = .left,
        removeSectionsIfEmpty: Bool = true
    ) {
        tableView.performBatchUpdates({
            for indexPath in indexPaths {
                sections[indexPath.section].removeRow(at: indexPath.row)
            }
            tableView.deleteRows(at: indexPaths, with: animation)
            
            // Remove the empty sections, if needed.
            if removeSectionsIfEmpty {
                let sectionIndices = Set(indexPaths.map({ $0.section }))
                
                for sectionIndex in sectionIndices {
                    if sections[sectionIndex].rowCount == 0 {
                        removeSection(at: sectionIndex)
                    }
                }
            }
        })
    }
    
    /// Removes the first row in a section.
    ///
    /// When the row is removed, if there are no rows in the section remaining, then the section
    /// will also be removed.
    ///
    /// - Parameters:
    ///   - section: The index of the section to remove the first row of.
    ///   - animation: The animation that should be used to remove the row.
    open func removeFirstRow(in section: Int, animation: UITableView.RowAnimation = .bottom) {
        let indexPath = IndexPath(row: 0, section: section)
        removeRow(at: indexPath, animation: animation)
    }
    
    /// Removes the last row in a section.
    ///
    /// When the row is removed, if there are no rows in the section remaining, then the section
    /// will also be removed.
    ///
    /// - Parameters:
    ///   - section: The index of the section to remove the first row of.
    ///   - animation: The animation that should be used to remove the row.
    open func removeLastRow(in section: Int, animation: UITableView.RowAnimation = .top) {
        let indexPath = IndexPath(row: sections[section].rowCount - 1, section: section)
        removeRow(at: indexPath, animation: animation)
    }
    
    /// Removes the first occurrence of a row.
    ///
    /// When the row is removed, if there are no rows in the section remaining, then the section
    /// will also be removed.
    ///
    /// - Parameters:
    ///   - section: The index of the section to remove the first row of.
    ///   - animation: The animation that should be used to remove the row.
    open func remove<T: Row>(firstOccurrenceOf row: T) {
        if let indexPath = indexPath(of: row) {
            removeRow(at: indexPath)
        }
    }
    
    /// Removes the first row where a condition is met.
    ///
    /// When the row is removed, if there are no rows in the section remaining, then the section
    /// will also be removed.
    ///
    /// - Parameters:
    ///   - condition: The condition that must be met to remove the row.
    ///   - animation: The animation that should be used to remove the row.
    open func removeFirst(where condition: (AnyRow) -> (Bool)) {
        if let indexPath = firstIndexPath(where: condition) {
            removeRow(at: indexPath)
        }
    }
    
    /// Moves the row at an index path to a new index path.
    ///
    /// When the row is moved, if there are no rows in the original section remaining, then the
    /// section will also be removed.
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the row that should be moved.
    ///   - newIndexPath: The index path to move the row to.
    open func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.performBatchUpdates({
            let temp = item(at: indexPath)
            sections[indexPath.section].removeRow(at: indexPath.row)
            sections[newIndexPath.section].insertRow(temp, at: newIndexPath.row)
            
            // Remove the old section, if needed.
            if sections[indexPath.section].rowCount == 0 {
                removeSection(at: indexPath.section)
            }
            
            tableView.moveRow(at: indexPath, to: newIndexPath)
        })
    }
    
    /// Replaces the row at an index path with a new row.
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the row to be replaced.
    ///   - newRow: The row to replace the current row with.
    ///   - outAnimation: The animation to be used when removing the current row.
    ///   - inAnimation: The animation to be used when inserting the new row.
    open func replaceRow<T: Row>(
        at indexPath: IndexPath,
        with newRow: T,
        outAnimation: UITableView.RowAnimation = .top,
        inAnimation: UITableView.RowAnimation = .top
    ) {
        tableView.performBatchUpdates({
            removeRow(at: indexPath, animation: outAnimation, removeSectionIfEmpty: false)
            insertRow(newRow, at: indexPath, animation: inAnimation)
        })
    }
    
    
    // MARK: - Section Operations
    
    /// Removes the section at an index.
    ///
    /// - Parameters:
    ///   - index: The index of the section to be removed.
    ///   - animation: The animation that should be used to remove the section.
    open func removeSection(at index: Int, animation: UITableView.RowAnimation = .left) {
        sections.remove(at: index)
        tableView.deleteSections(IndexSet(integer: index), with: animation)
    }
    
    /// Moves the section at an index to a new index.
    ///
    /// - Parameters:
    ///   - index: The index of the section to move.
    ///   - newIndex: The index to move the section to.
    open func moveSection(at index: Int, to newIndex: Int) {
        let temp = sections.remove(at: index)
        sections.insert(temp, at: newIndex)
        
        tableView.moveSection(index, toSection: newIndex)
    }
    
    /// Inserts a new section into the data source and table view.
    ///
    /// - Parameters:
    ///   - section: The new section to be inserted.
    ///   - index: The index to insert the section at.
    ///   - animation: The animation to be used when inserting the new section.
    open func insertSection(
        _ section: Section,
        at index: Int,
        animation: UITableView.RowAnimation = .top
    ) {
        sections.insert(section, at: index)
        tableView.insertSections(IndexSet(integer: index), with: animation)
    }
    
    /// Replaces the section at the index with a new one.
    ///
    /// - Parameters:
    ///   - index: The index of the section to be replaced.
    ///   - newSection: The section to be inserted.
    ///   - outAnimation: The animation to be used when removing the current section.
    ///   - inAnimation: The animation to be used when inserting the new section.
    open func replaceSection(
        at index: Int,
        with newSection: Section,
        outAnimation: UITableView.RowAnimation = .top,
        inAnimation: UITableView.RowAnimation = .top
    ) {
        tableView.performBatchUpdates({
            removeSection(at: index, animation: outAnimation)
            insertSection(newSection, at: index, animation: inAnimation)
        })
    }
}
