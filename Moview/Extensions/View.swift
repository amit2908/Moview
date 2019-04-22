//
//  ViewExtension.swift
//  Pey
//
//  Created by Apple on 15/04/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import UIKit

/*------------------------------------------------------------------------------------------------------------
 UIView Extensions
 ------------------------------------------------------------------------------------------------------------*/

extension UIView {
    /*
     Fix content views of Views with XIB's in the Parent Views to make it resizable
     */
    func fixInView(_ container: UIView!) -> Void{
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.frame = container.frame;
    container.addSubview(self);
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    /*
     Add Shadow to any view
     */
    
    func addShadowToView(shadowColor: UIColor?, cornerRadius: CGFloat?, shadowRadius: CGFloat? , shadowOffset: CGSize?, shadowOpacity: Float?, shadowPath: CGPath?, clip: Bool? = false, xGap: Float = 31.0){
    let gap = CGFloat(xGap)
    let offset = shadowOffset ?? CGSize(width: 0.0, height: 5.0)
    let gaussianPath = UIBezierPath()
    gaussianPath.move(to: CGPoint(x: gap, y: bounds.size.height - 40))
    gaussianPath.addLine(to: CGPoint(x: bounds.size.width - gap, y: bounds.size.height - 40))
    gaussianPath.addLine(to: CGPoint(x: bounds.size.width - gap, y: bounds.size.height + offset.height))
    gaussianPath.addLine(to: CGPoint(x: gap, y: bounds.size.height + offset.height))
    gaussianPath.addLine(to: CGPoint(x: gap, y: bounds.size.height - 40))
    gaussianPath.close()
    
    layer.shadowColor = UIColor.appShadowColor.cgColor
    layer.shadowPath = shadowPath ?? gaussianPath.cgPath
    layer.shadowOffset = shadowOffset ?? CGSize(width: 0.0, height: offset.height)
    layer.shadowRadius = shadowRadius ?? 7.5
    layer.cornerRadius = cornerRadius ?? 5.0
    layer.shadowOpacity = shadowOpacity ?? 0.5
    if clip == true {
    clipsToBounds = true
    layer.masksToBounds = true
    }else {
    clipsToBounds = false
    layer.masksToBounds = false
    }
    //        layer.frame = self.bounds
    }
    
    
    func removeShadow(){
    layer.shadowOpacity = 0
    }
    
    func addShadowToView1(shadowLayer: CALayer, shadowColor: UIColor?, cornerRadius: CGFloat?, shadowRadius: CGFloat? , shadowOffset: CGSize?, shadowOpacity: Float?, shadowPath: CGPath?, clip: Bool? = false, xGap: Float = 31.0){
    let gap = CGFloat(xGap)
    let offset = shadowOffset ?? CGSize(width: 0.0, height: 5.0)
    let gaussianPath = UIBezierPath()
    gaussianPath.move(to: CGPoint(x: gap, y: frame.size.height - 40))
    gaussianPath.addLine(to: CGPoint(x: frame.size.width - gap, y: frame.size.height - 40))
    gaussianPath.addLine(to: CGPoint(x: frame.size.width - gap, y: frame.size.height + offset.height))
    gaussianPath.addLine(to: CGPoint(x: gap, y: frame.size.height + offset.height))
    gaussianPath.addLine(to: CGPoint(x: gap, y: frame.size.height - 40))
    gaussianPath.close()
    
    shadowLayer.shadowColor = UIColor.appShadowColor.cgColor
    shadowLayer.shadowPath = shadowPath ?? gaussianPath.cgPath
    shadowLayer.shadowOffset = shadowOffset ?? CGSize(width: 0.0, height: offset.height)
    shadowLayer.shadowRadius = shadowRadius ?? 7.5
    shadowLayer.cornerRadius = cornerRadius ?? 5.0
    shadowLayer.shadowOpacity = shadowOpacity ?? 0.5
    
    if clip == true {
    clipsToBounds = true
    shadowLayer.masksToBounds = true
    }else {
    clipsToBounds = false
    shadowLayer.masksToBounds = false
    }
    shadowLayer.zPosition = 0
    layer.zPosition = 100
    layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func removeShadow1(shadowLayer: CALayer){
    shadowLayer.removeFromSuperlayer()
    }
    
    /*
     Add Gradient Layer to view
     */
    enum GradientDirection: Int {
    case leftToRight = 1, topLeftToBottomRight, topRightToBottomLeft
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, direction: GradientDirection) {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame
    gradientLayer.colors = [colorOne.cgColor,colorTwo.cgColor]
    //        gradientLayer.locations = [1.0,1.0]
    if direction == .topLeftToBottomRight {
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
    else if direction == .leftToRight {
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    else if direction == .topRightToBottomLeft {
    gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.1)
    }
    layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    /*
     Added animation dispatch group to manage animation in a cooler way
     */
    static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?){
    group.enter()
    animate(withDuration: duration, animations: animations) { (success) in
    completion?(success)
    }
    group.leave()
    }
    
    func shakeError(duration: Float, repeatCount: Float){
        let fromPosition = Float(layer.position.x - 20)
        let toPosition = Float(layer.position.x + 20)
        DispatchQueue.global(qos: .default).async {
            let shakeAnimation = CABasicAnimation.init(keyPath: "position.x")
            shakeAnimation.duration = CFTimeInterval(duration)
            shakeAnimation.repeatCount = repeatCount
            shakeAnimation.repeatDuration = Double(duration) * Double(repeatCount)
            shakeAnimation.fromValue = fromPosition
            shakeAnimation.toValue = toPosition
            shakeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shakeAnimation.autoreverses = true
            
            DispatchQueue.main.async {
                self.layer.add(shakeAnimation, forKey: "shake")
            }
        }
        
    }
}
