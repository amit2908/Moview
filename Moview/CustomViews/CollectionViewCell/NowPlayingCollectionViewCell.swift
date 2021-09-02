//
//  NowPlayingCollectionViewCell.swift
//  Moview
//
//  Created by Empower on 29/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell, GenericCollectionCell {
   
    @IBOutlet weak var imgV_poster: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btn_favourite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btn_favourite.setImage(UIImage.init(named: "favourite-unselected"), for: .normal)
    }
    
    func configure(withData data: Any?) {
        if let movie = data as? IMovie {
//            self.imgV_poster.image = UIImage.init(contentsOfFile: movie.imageLink)
            lbl_name.text = movie.title
        }
    }
    
}
