//
//  UIShadowFooterView.swift
//  ExtendedTableViewController
//
//  Created by Austin-Michael Komatz on 1/8/19.
//  Copyright © 2019 Three Wing Studios. All rights reserved.
//

import Foundation
import UIKit

/// A simple view that displays a shadow as the footer in a table view.
///
/// For easy use of this class, use the for(_:height:) class method to get an instance of
/// UIShadowFooterView, sized specifically for the specified table view.
public class UIShadowFooterView: UITableViewHeaderFooterView, Reusable {
    
    public class var reuseIdentifier: String {
        return "UIShadowFooterView"
    }
    
    private var didSetup = false
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if didSetup == false {
            setup()
            didSetup = true
        }
    }
    
    /// Adds a gradient to the view. This gives the appearance of a shadow.
    private func setup() {
        let gradient = CAGradientLayer()
        gradient.frame.size = CGSize(width: bounds.width, height: 10)
        
        gradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor,
            UIColor.clear.cgColor]
        gradient.locations = [0, 0.75]
        
        layer.addSublayer(gradient)
    }
    
}
