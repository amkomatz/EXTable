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
    associatedtype CellType: ConfigurableTableViewCell where CellType.DataType == DataType
    
    var data: DataType { get set }
    
    init(data: DataType)
    
    func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType
    
}

public protocol RowResponder {
    
    var onWillSelect: ((IndexPath) -> (IndexPath))? { get set }
    var onDidSelect: ((IndexPath) -> ())? { get set }
    
    var onWillDeselect: ((IndexPath) -> (IndexPath))? { get set }
    var onDidDeselect: ((IndexPath) -> ())? { get set }
    
    var onWillDisplay: ((IndexPath) -> ())? { get set }
    var onDidDisplay: ((IndexPath) -> ())? { get set }
    
}

public protocol ConfigurableRow: Row {
    
    var configuration: ((CellType) -> ())? { get set }
    
}

public extension Row {
    
    public func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellType.self.reuseIdentifier,
            for: indexPath
        ) as! CellType
        
        cell.configure(for: data)
        return cell
    }
    
}

public extension ConfigurableRow {
    
    public func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> CellType {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellType.self.reuseIdentifier,
            for: indexPath
        ) as! CellType
        
        cell.configure(for: data)
        configuration?(cell)
        
        return cell
    }
    
}
