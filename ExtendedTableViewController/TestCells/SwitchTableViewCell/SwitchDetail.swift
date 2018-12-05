//
//  SwitchDetail.swift
//  AnyTableViewRowTesting
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class SwitchDetail {
    
    var title: String
    var switchIsOn: Bool
    var onSwitchValueChange: (UISwitch) -> ()
    
    init(title: String, switchIsOn: Bool, onSwitchValueChange: @escaping (UISwitch) -> ()) {
        self.title = title
        self.switchIsOn = switchIsOn
        self.onSwitchValueChange = onSwitchValueChange
    }
    
    @objc func switchValueDidChange(_ switchView: UISwitch) {
        onSwitchValueChange(switchView)
    }
    
}
