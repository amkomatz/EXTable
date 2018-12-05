//
//  AnyRow.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

internal protocol _AnyRowBox {
    
    var _base: Any { get }
    
    func _unbox<T: Row>() -> T?
    func _isEqual(to rhs: _AnyRowBox) -> Bool
    
    func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell?
    
}

internal struct _ConcreteRowBox<Base: Row>: _AnyRowBox {
    
    internal var _baseRow: Base
    
    var _base: Any {
        return _baseRow
    }
    
    internal init(_ base: Base) {
        self._baseRow = base
    }
    
    func _unbox<T: Row>() -> T? {
        return (self as _AnyRowBox as? _ConcreteRowBox<T>)?._baseRow
    }
    
    func _isEqual(to rhs: _AnyRowBox) -> Bool {
        if let rhs: Base = rhs._unbox() {
            return _baseRow == rhs
        }
        return false
    }
    
    func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell? {
        if let row: Base = _unbox() {
            return row.configuredCell(for: tableView, at: indexPath)
        }
        return nil
    }
    
}

public struct AnyRow {
    
    internal var _box: _AnyRowBox
    
    internal init(_box: _AnyRowBox) {
        self._box = _box
    }
    
    public init<R: Row>(_ base: R) {
        self.init(_box: _ConcreteRowBox(base))
    }
    
    public var base: Any {
        return _box._base
    }
    
    public func configuredCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell? {
        return _box.configuredCell(for: tableView, at: indexPath)
    }
    
}

extension AnyRow: Equatable {
    
    public static func == (lhs: AnyRow, rhs: AnyRow) -> Bool {
        return lhs._box._isEqual(to: rhs._box)
    }
    
}

public extension Array where Element == AnyRow {
    
    public mutating func append<T: Row>(_ newElement: T) {
        append(AnyRow(newElement))
    }
    
}
