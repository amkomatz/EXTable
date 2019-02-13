//
//  ViewController.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class ViewController: EXTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultFooter(UIShadowFooterView.self, height: 5)
    }
    
    override func generateSections() -> [Section] {
        var sections: [Section] = []
        
        var section1 = Section()
        section1.headerTitle = "Section 1"
        section1.appendRow(IntRow(data: 1))
        section1.appendRow(StringRow(data: "Awesome"))
        section1.appendRow(IntRow(data: 22))
        sections.append(section1)
        
        var section2 = Section()
        section2.headerTitle = "Section 2"
        var thirteen = IntRow(data: 13)
        thirteen.configuration = { cell in
            cell.textLabel?.textColor = .red
        }
        section2.appendRow(thirteen)
        section2.appendRow(StringRow(data: "So cool"))
        section2.appendRow(StringRow(data: "Heck yeah"))
        sections.append(section2)
        
        var section3 = Section()
        let switchDetail = SwitchDetail(
            title: "Switch Me!",
            switchIsOn: false,
            onSwitchValueChange: switchDidChangeValue)
        section3.appendRow(SwitchRow(data: switchDetail))
        sections.append(section3)
        
        var section4 = Section()
        var untappableRow = StringRow(data: "I bet you can't tap me")
        untappableRow.onWillSelect = { indexPath in
            // Make the next row get tapped.
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
        section4.appendRow(untappableRow)
        section4.appendRow(StringRow(data: "I hate being tapped"))
        var strRow = StringRow(data: "You can tap me, it's ok")
        strRow.onDidSelect = { indexPath in
            guard let row = self.item(at: indexPath).as(StringRow.self) else { return }
            print(row.data)
            self.alert("There is no escaping")
        }
        section4.appendRow(strRow)
        sections.append(section4)
        
        return sections
    }
    
    func switchDidChangeValue(_ switchView: UISwitch) {
        switch switchView.isOn {
        case true:
            appendRow(IntRow(data: 10), to: 2)
            
        case false:
            removeLastRow(in: 2)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func alert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
    
}

