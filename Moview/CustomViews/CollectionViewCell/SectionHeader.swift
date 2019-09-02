//
//  SectionHeader.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var btn_showMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionHeaderLabel.font = UIFont.appFontBold16
        btn_showMore.titleLabel?.font = UIFont.appFontBold16
    }
}
