//
//  UIView+CodeConcisers.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

extension UIView {
    static func hide(views: [UIView]) {
        views.forEach{ $0.isHidden = true }
    }
    
    static func unhide(views: [UIView]) {
        views.forEach{ $0.isHidden = false }
    }
}
