//
//  EXTableViewController+UITableViewDataSource.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 12/5/18.
//  Copyright © 2018 Austin-Michael Komatz. All rights reserved.
//

import UIKit

extension EXTableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section].rowCount
    }
    
    open override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return sections[indexPath.section].cellForRow(at: indexPath, in: tableView)
    }
    
}
