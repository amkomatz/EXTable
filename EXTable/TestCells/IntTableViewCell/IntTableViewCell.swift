//
//  IntTableViewCell.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class IntTableViewCell: ConfigurableTableViewCell {
    
    class var reuseIdentifier: String { return "IntTableViewCell" }
    class var bundle: Bundle { return Bundle(for: IntTableViewCell.self) }
    class var nib: UINib { return UINib(nibName: "IntTableViewCell", bundle: bundle) }
    
    func configure(for value: Int) {
        textLabel?.text = "Value"
        detailTextLabel?.text = String(value)
    }
    
}
