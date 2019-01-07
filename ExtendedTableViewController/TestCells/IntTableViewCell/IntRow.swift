//
//  IntRow.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation

struct IntRow: ConfigurableRow, RowResponder {
    
    static func == (lhs: IntRow, rhs: IntRow) -> Bool {
        return lhs.data == rhs.data
    }
    
    typealias DataType = Int
    typealias CellType = IntTableViewCell
    
    var data: Int
    var configuration: ((IntTableViewCell) -> ())?
    
    init(data: Int) {
        self.data = data
    }
    
    var onWillSelect: ((IndexPath) -> (IndexPath))?
    var onDidSelect: ((IndexPath) -> ())?
    var onWillDeselect: ((IndexPath) -> (IndexPath))?
    var onDidDeselect: ((IndexPath) -> ())?
    var onWillDisplay: ((IndexPath) -> ())?
    var onDidDisplay: ((IndexPath) -> ())?
    
}
