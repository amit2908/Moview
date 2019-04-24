//
//  CustomNavigationBar.swift
//  Moview
//
//  Created by Empower on 24/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {

    private var position : UIBarPosition = .top
    
    @IBOutlet open var contentView : UIView!
    @IBOutlet weak var topItem: UIView!
    @IBOutlet weak var leftItem: UIView!
    @IBOutlet weak var rightItem: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btn_left: UIButton!
    
    open var barPosition: UIBarPosition {
        get {
            return self.position
        }
        set {
            self.position = barPosition
        }
    }
    
    open var title: String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    open var hasGradient: Bool = true {
        didSet {
            if hasGradient == true {
                self.setBackground()
            }else {
                self.removeGradient()
            }
        }
    }
    
    weak var delegate : UINavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setBackground()
    }
    
    private func setupView(){
        Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)
        contentView.tintColor = UIColor.blue
        contentView.fixInView(self)
    }
    
    func setBackground(){
        self.backgroundColor = UIColor.clear
        self.addGradientBackground()
    }
    
    func addGradientBackground(){
        self.contentView.setGradientBackground(colorOne: .softBlue, colorTwo: .cornflower, direction: .leftToRight)
    }
    
    func removeGradient(){
        let sublayers = self.contentView.layer.sublayers
        guard let gradient = sublayers?[0] else {
            fatalError("You are trying to remove a layer which is not even added!")
        }
        gradient.removeFromSuperlayer()
    }

}
