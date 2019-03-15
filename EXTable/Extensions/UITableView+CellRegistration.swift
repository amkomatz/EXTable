//
//  UITableView+CellRegistration.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Registers a table view cell that conforms to `CellLoadable`.
    public func register(_ cell: CellLoadable.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    /// Registers a header/footer view for the table view.
    public func register(_ headerFooterView: (UITableViewHeaderFooterView & Reusable).Type) {
        register(
            headerFooterView,
            forHeaderFooterViewReuseIdentifier: headerFooterView.reuseIdentifier
        )
    }
    
}
