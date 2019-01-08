//
//  ViewController.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

class ViewController: EXTableViewController {
    
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
        tableView.deselectRow(at: indexPath, animated: true)
        
//        removeRow(at: indexPath)
//        appendRow(IntRow(data: 10), to: indexPath.section)
//        insertRow(IntRow(data: 10), at: indexPath)
//        prependRow(IntRow(data: 10), in: indexPath.section)
//        remove(firstOccurrenceOf: IntRow(data: 22))
//        moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
//        moveSection(at: indexPath.section, to: 0)
        
//        var section = Section()
//        section.addRow(IntRow(data: 100))
//        section.addRow(IntRow(data: 200))
//        section.addRow(IntRow(data: 300))
//        insertSection(section, at: 0)
        
        replaceRow(at: indexPath, with: IntRow(data: Int(arc4random())), outAnimation: .left, inAnimation: .right)
    }
    
}

