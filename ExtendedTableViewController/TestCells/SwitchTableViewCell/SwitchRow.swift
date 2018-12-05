//
//  SwitchRow.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import Foundation

struct SwitchRow: Row {
    
    typealias DataType = SwitchDetail
    typealias CellType = SwitchTableViewCell
    
    var data: SwitchDetail
    
    init(data: SwitchDetail) {
        self.data = data
    }
    
    static func == (lhs: SwitchRow, rhs: SwitchRow) -> Bool {
        return lhs.data === rhs.data
    }
    
}
