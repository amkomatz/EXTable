//
//  StringRow.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation

struct StringRow: Row {
    
    typealias DataType = String
    typealias CellType = StringTableViewCell
    
    var data: String
    
    init(data: String) {
        self.data = data
    }
    
}
