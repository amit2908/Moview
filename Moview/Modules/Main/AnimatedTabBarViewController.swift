//
//  AnimatedTabBarViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class AnimatedTabBarViewController: RAMAnimatedTabBarController{
    let customTabBar = TabBarWithCorners()
    
//    override var tabBar: UITabBar {
//        return customTabBar
//    }
//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.dashboard)
        
        let favouritesVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.favourites)
        
        self.viewControllers = [dashboardVC, favouritesVC]
    
    }
    

}

class TabBarWithCorners: UITabBar {
    var color: UIColor = .red
    var radii: CGFloat = 15.0

    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }

    private func addShape() {
        
        let shapeLayer = CAShapeLayer()
    
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.red.withAlphaComponent(0.5).cgColor
        shapeLayer.fillColor = color.cgColor
        shapeLayer.lineWidth = 1
    
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
    
        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
    
        return path.cgPath
    }
}
