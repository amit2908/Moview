//
//  MovieCollectionViewCell.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgV_movie: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius  = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        self.layer.masksToBounds = true
        lbl_title.font = UIFont.appFontRegular14
    }
}
