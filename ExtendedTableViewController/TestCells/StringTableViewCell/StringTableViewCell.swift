//
//  StringTableViewCell.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class StringTableViewCell: ConfigurableTableViewCell {
    
    class var reuseIdentifier: String { return "StringTableViewCell" }
    class var bundle: Bundle { return Bundle(for: StringTableViewCell.self) }
    class var nib: UINib { return UINib(nibName: "StringTableViewCell", bundle: bundle) }
    
    func configure(for value: String) {
        textLabel?.text = "Value"
        detailTextLabel?.text = value
    }
    
}
