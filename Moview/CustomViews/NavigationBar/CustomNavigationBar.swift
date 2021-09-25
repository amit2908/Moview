//
//  CustomNavigationBar.swift
//  Moview
//
//  Created by Empower on 24/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

/// This class can provide a beautiful customized navigation bar.
class CustomNavigationBar: UINavigationBar {

    private var position : UIBarPosition = .top
    
    @IBOutlet open var contentView : UIView!
    @IBOutlet weak var top_Item: UIView!
    @IBOutlet weak var leftItem: UIView!
    @IBOutlet weak var rightItem: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btn_left: UIButton!
    @IBOutlet weak var btn_right: UIButton!
    
    override open var barPosition: UIBarPosition {
        get {
            return self.position
        }
        set {
            self.position = newValue
        }
    }
    
    @IBInspectable
    open var title: String?
    
    open var hasGradient: Bool = true {
        didSet {
            if hasGradient == true {
                self.removeGradient()
                self.setBackground()
            }else {
                self.removeGradient()
            }
        }
    }
    
    
    override func awakeFromNib() {
        setupView()
        self.titleLabel.text = title
        self.titleLabel.layer.zPosition = 100.0
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let _ = self.layer.sublayers?.map{ $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.bounds.size.height) }
    }

    
    private func setupView(){
        Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)
        contentView.tintColor = UIColor.blue
        contentView.fixInView(self)
        setBackground()
        
        self.titleLabel.font = UIFont.appFontBold25
    }
    
    func setBackground(){
        self.backgroundColor = UIColor.clear
        self.addGradientBackground()
    }
    
    func addGradientBackground(){
        self.setGradientBackground(array: [UIColor.red.cgColor, UIColor.softBlue.cgColor, UIColor.white.cgColor], direction: .leftToRight)
    }
    
    func removeGradient(){
        let sublayers = self.contentView.layer.sublayers
        guard let gradient = sublayers?[0] else {
            fatalError("You are trying to remove a layer which is not even added!")
        }
        gradient.removeFromSuperlayer()
    }

}
