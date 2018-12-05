//
//  SwitchTableViewCell.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class SwitchTableViewCell: ConfigurableTableViewCell {
    
    class var reuseIdentifier: String { return "SwitchTableViewCell" }
    class var bundle: Bundle { return Bundle(for: SwitchTableViewCell.self) }
    class var nib: UINib { return UINib(nibName: "SwitchTableViewCell", bundle: bundle) }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var switchView: UISwitch!
    
    func configure(for detail: SwitchDetail) {
        titleLabel.text = detail.title
        switchView.isOn = detail.switchIsOn
        switchView.addTarget(
            detail, action:
            #selector(SwitchDetail.switchValueDidChange),
            for: .valueChanged
        )
    }
    
}
