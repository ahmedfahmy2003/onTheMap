//
//  File.swift
//  onTheMap
//
//  Created by Ahmed Fahmy on 08/02/2019.
//  Copyright © 2019 Mohtaref. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    
    private static weak var _currentFirstResponder: UIResponder?
    
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        
        return _currentFirstResponder
    }
    
    @objc func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}
