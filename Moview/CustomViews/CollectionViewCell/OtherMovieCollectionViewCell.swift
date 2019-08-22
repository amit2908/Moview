//
//  OtherMovieCellCollectionViewCell.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class OtherMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgV_movie: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius  = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        self.layer.masksToBounds = true
    }
}
