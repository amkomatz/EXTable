//
//  Responders.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 2/13/19.
//  Copyright © 2019 Three Wing Studios. All rights reserved.
//

import Foundation

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


// MARK: - Swipe Actions

public typealias SwipeActionContaining =
    LeadingSwipeActionContaining &
    TrailingSwipeActionContaining

public protocol TrailingSwipeActionContaining {
    
    var trailingSwipeActions: [UIContextualAction]? { get set }
}

public protocol LeadingSwipeActionContaining {
    
    var leadingSwipeActions: [UIContextualAction]? { get set }
}


// MARK: - Accessibility

public protocol AccessibilityContaining {
    
    var accessibilityHint: String? { get set }
    var accessibilityLabel: String? { get set }
    var accessibilityValue: String? { get set }
    var accessibilityTraits: UIAccessibilityTraits? { get set }
    var accessibilityIdentifier: String? { get set }
}
