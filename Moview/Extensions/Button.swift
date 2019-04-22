//
//  Button.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit


extension UIButton {
    
    func centerButtonAndImageWithSpacing() {
        let horizontalSpacing = 10.0 ; // the amount of spacing to appear between image and title
        let verticalSpacing = 0.0 ; // the amount of spacing to appear between image and title
        self.imageEdgeInsets = UIEdgeInsets(top: CGFloat(verticalSpacing), left: CGFloat(horizontalSpacing), bottom: CGFloat(verticalSpacing), right: CGFloat(horizontalSpacing));
        self.titleEdgeInsets = UIEdgeInsets(top: CGFloat(verticalSpacing), left: CGFloat(horizontalSpacing), bottom: CGFloat(verticalSpacing), right: CGFloat(horizontalSpacing) );
    }
    
    func setBorderAndTintColor() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.brown.cgColor
        //        self.setTitleColor(.white, for: .normal)
    }
    
    func setBorderWidthAndBorderColor() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.brown.cgColor
        //        self.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
    }
    
}
