//
//  Responders.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 1/14/19.
//  Copyright © 2019 Three Wing Studios. All rights reserved.
//

import UIKit

public typealias FullResponder = SelectionResponder & DeselectionResponder & WillDisplayResponder


// MARK: - Selection

public protocol WillSelectResponder {
    var onWillSelect: ((IndexPath) -> (IndexPath))? { get set }
}

public protocol DidSelectResponder {
    var onDidSelect: ((IndexPath) -> ())? { get set }
}

public typealias SelectionResponder = WillSelectResponder & DidSelectResponder


// MARK: - Deselection

public protocol WillDeselectResponder {
    var onWillDeselect: ((IndexPath) -> (IndexPath))? { get set }
}

public protocol DidDeselectResponder {
    var onDidDeselect: ((IndexPath) -> ())? { get set }
}

public typealias DeselectionResponder = WillDeselectResponder & DidDeselectResponder


// MARK: - Displaying

public protocol WillDisplayResponder {
    var onWillDisplay: ((IndexPath) -> ())? { get set }
}
