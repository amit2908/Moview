//
//  UIView+Custom.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseID: String {
        get{
            return String(describing: self)
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        
    }
    
    static func bundlePath() -> Bundle {
        return Bundle(for: self)
    }
}


