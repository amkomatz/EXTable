//
//  Reusable.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation

public protocol Reusable: class {
    
    static var reuseIdentifier: String { get }
    
}
