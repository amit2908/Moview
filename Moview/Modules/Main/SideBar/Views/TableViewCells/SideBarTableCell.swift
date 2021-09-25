//
//  SideBarTableCell.swift
//  Moview
//
//  Created by Shubham Ojha on 05/09/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class SideBarTableCell: UITableViewCell {
    
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var imgViewIcon : UIImageView!

    struct ViewModel {
        let title: String
        let icon : UIImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func configure(withViewModel vm: ViewModel) {
        self.lblTitle.text = vm.title
        self.imgViewIcon.image = vm.icon
    }
    
}
