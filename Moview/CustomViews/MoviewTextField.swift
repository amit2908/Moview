//
//  MoviewTextField.swift
//  Moview
//
//  Created by Shubham Ojha on 08/10/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class MoviewTextField: UITextField {
    
    @IBInspectable var image: UIImage? {
        didSet {
            if let localImage = image {
                imageView?.image = localImage
            }
        }
    }
    
    private var imageView : UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        self.cornerRadius = 10.0
        self.borderStyle = .none
        self.borderWidth = 2.0
        let color = UIColor(named: "AppColor")
        
        self.borderColor = color?.withAlphaComponent(0.7)
        
        self.leftView = UIView.init(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: self.bounds.height)))
        self.leftViewMode = .always
        
        imageView = UIImageView(frame: CGRect(x: 10, y: 13 , width: 15, height: 15))
        self.leftView?.addSubview(imageView!)
//        let constraints = self.createConstraints()
//        self.imageView?.addConstraints(constraints)
        
        
    }
    
    private func createConstraints() -> [NSLayoutConstraint] {
        
        let centerContraintX = NSLayoutConstraint(item: imageView!, attribute: .centerX, relatedBy: .equal, toItem: imageView?.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerContraintY = NSLayoutConstraint(item: imageView!, attribute: .centerY, relatedBy: .equal, toItem: imageView?.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        let widthConstraint = NSLayoutConstraint(item: imageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 15)
        let heightConstraint = NSLayoutConstraint(item: imageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15)
        
        return [centerContraintX ,centerContraintY, widthConstraint, heightConstraint]
    }
    
    
}
