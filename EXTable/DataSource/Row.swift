//
//  Row.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

/// A table view cell that can easily be loaded and configured.
public typealias ConfigurableTableViewCell = UITableViewCell & Configurable & CellLoadable

public protocol Configurable {
    
    associatedtype DataType: Any
    func configure(for data: DataType)
}

public protocol Row: Equatable {
    
    associatedtype DataType: Any
    associatedtype CellType: ConfigurableTableViewCell
    
    var id: String? { get }
    
    var data: DataType { get }
    var cellData: CellType.DataType { get }
    
    init(id: String?, data: DataType)
    
    func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType
}

public protocol ConfigurableRow: Row {
    
    var configuration: ((CellType) -> ())? { get set }
}

extension Row where CellType.DataType == DataType {
    
    public var cellData: CellType.DataType {
        data
    }
}

extension Row {
    
    public func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellType.self.reuseIdentifier,
            for: indexPath
        ) as! CellType
        
        if let accessibilityContainer = self as? AccessibilityContaining {
            cell.accessibilityHint = accessibilityContainer.accessibilityHint
            cell.accessibilityLabel = accessibilityContainer.accessibilityLabel
            cell.accessibilityValue = accessibilityContainer.accessibilityValue
            cell.accessibilityIdentifier = accessibilityContainer.accessibilityIdentifier
            
            if let accessibilityTraits = accessibilityContainer.accessibilityTraits {
                cell.accessibilityTraits = accessibilityTraits
            }
        }
        
        cell.configure(for: cellData)
        
        return cell
    }
}

extension ConfigurableRow {
    
    public func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellType.self.reuseIdentifier,
            for: indexPath
        ) as! CellType
        
        cell.configure(for: cellData)
        configuration?(cell)
        
        return cell
    }
}
