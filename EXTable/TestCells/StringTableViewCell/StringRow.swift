//
//  StringRow.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation

struct StringRow: Row, FullResponder {
    
    static func == (lhs: StringRow, rhs: StringRow) -> Bool {
        return lhs.data == rhs.data
    }
    
    typealias DataType = String
    typealias CellType = StringTableViewCell
    
    var id: String?
    
    var data: String
    
    init(id: String?, data: String) {
        self.data = data
    }
    
    var onWillSelect: ((IndexPath) -> (IndexPath))?
    var onDidSelect: ((IndexPath) -> ())?
    var onWillDeselect: ((IndexPath) -> (IndexPath))?
    var onDidDeselect: ((IndexPath) -> ())?
    var onWillDisplay: ((IndexPath) -> ())?
}
