//
//  CellRegistrable.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

/// Protocol giving the conforming type the ability to register cells in a table view.
public protocol CellRegistrable: class {
    
    var cellClasses: [(CellLoadable & UITableViewCell).Type] { get }
    
    /// Registers the required cells for the table view.
    ///
    /// This should only be called once for the entire lifecycle of the view controller, as
    /// it is only necessary to register the cells once.
    ///
    /// - Important: When subclassing, the implementation from the superclass should be called to
    /// ensure that all cells that were registered in the parent class are available in the
    /// subclass.
    func registerCells()
    
}

public extension CellRegistrable where Self: UITableViewController {
    
    public func registerCells() {
        for cellClass in cellClasses {
            tableView.register(cellClass)
        }
    }
    
}
