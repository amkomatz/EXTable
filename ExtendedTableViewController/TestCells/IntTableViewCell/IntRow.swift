//
//  IntRow.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

struct IntRow: Row {
    
    typealias DataType = Int
    typealias CellType = IntTableViewCell
    
    var data: Int
    
    init(data: Int) {
        self.data = data
    }
    
}
