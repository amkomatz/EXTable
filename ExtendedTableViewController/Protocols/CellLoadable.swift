//
//  CellLoadable.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

/// Protocol giving easy loading to a table view or collection view cell.
///
/// - Important: The best practice for declaring a cell that can be loaded is to create it in it's
/// own NIB file with the name of the class. The reuse identifier should also be the name of the
/// class, and and should be consistent with the reuse identifier used in the NIB. This ensures that
/// there is total consistency throughout the entire use of the cell.
public protocol CellLoadable: Reusable {
    
    /// The reuse identifier to use when registering/dequeuing the cell.
    ///
    /// - Important: The value of this property must be consistent with the reuse identifier used in
    /// the NIB file. Otherwise, a crash will likely occur. It is also highly recommended that the
    /// reuse identifier, in both places, match the name of the class. This helps ensure consistency
    /// wherever the cell is used.
    static var reuseIdentifier: String { get }
    
    /// The bundle that the cell's NIB file is in.
    ///
    /// It is recommended that this property is implemented in the following manner to ensure that
    /// the correct bundle is loaded.
    /// ```
    /// class var bundle: Bundle {
    ///     return Bundle(for: self)
    /// }
    /// ```
    static var bundle: Bundle { get }
    
    /// The NIB that the cell is in.
    ///
    /// - Important: It is highly recommended that the name of the NIB file is the same as the name
    /// of the cell's class. This is to ensure consistency wherever the app is being used.
    static var nib: UINib { get }
    
}
