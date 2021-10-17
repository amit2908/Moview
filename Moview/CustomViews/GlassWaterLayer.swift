//
//  GlassWaterLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 07/10/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class GlassWaterLayer: CAShapeLayer {
    private var shapePath : UIBezierPath = UIBezierPath()
    private var newPath : UIBezierPath = UIBezierPath()
    
    private var amplitude = 15.0
    
    // Number of h
    var frequency = 20
    
    // Legnth of one wave
    var waveLength = 120.0
    
    private var offset  = CGFloat(20.0)
    
    weak var fluidDelegate : FluidAnimationDelegate?
    
    override var frame: CGRect {
        didSet {
            frequency = 1
            waveLength = Double(SCREEN_WIDTH * 2)
            let yAxisMax: Double = Double(self.bounds.height * 2/3)
            let xCP = 30.0
//            shapePath = constructGlassLiquidPath(amplitude: amplitude, xCP: xCP, y: yAxisMax)
            shapePath = constructGlassLiquidPath(amplitude: amplitude, xCP: xCP, y: yAxisMax)
            
            self.path = shapePath.cgPath
            //            shapeLayer.strokeColor = UIColor.black.cgColor
//            self.fillColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
            
            self.fillColor = UIColor(named: "AppColor")?.withAlphaComponent(0.3).cgColor
            
            offset = -offset
            // final path
            newPath = constructGlassLiquidPath(amplitude: amplitude, xCP: Double(SCREEN_WIDTH) - xCP, y: yAxisMax)
        }
    }
    
    
    private func constructWavePath(amplitude: Double) -> UIBezierPath{
        let path = UIBezierPath()
        
        let initialPoint = CGPoint(x: 0.0, y: amplitude)
        path.move(to: initialPoint)
        
        //        let waveLength = Float(self.bounds.size.width)/Float(frequency)
        let halfLength = waveLength/2
        
        for i in 1...frequency {
            let nextPoint = CGPoint(x: Double(halfLength) * Double(i), y: amplitude)
            let controlPoints = getControlPointsForWavePath(forAmplitude: Float(amplitude), waveNo: i, waveLength: Float(waveLength), nextPoint: nextPoint)
            path.addCurve(to: nextPoint, controlPoint1: controlPoints.0, controlPoint2: controlPoints.1)
        }
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path.addLine(to: initialPoint)
        path.close()
        
        return path
    }
    
    private func getControlPointsForWavePath(forAmplitude amplitude: Float, waveNo: Int, waveLength: Float, nextPoint: CGPoint) -> (CGPoint, CGPoint){
        let halfLength = waveLength/2
        
        let cp1 = CGPoint(x: nextPoint.x - CGFloat(halfLength) * 3/4, y: waveNo % 2 == 0 ? CGFloat(nextPoint.y + offset) : CGFloat(-nextPoint.y + offset))
        let cp2 = CGPoint(x: nextPoint.x - CGFloat(halfLength) * 1/4, y: waveNo % 2 == 0 ? CGFloat(nextPoint.y + offset) : CGFloat(-nextPoint.y + offset))
        return (cp1, cp2)
    }
    
    
    
    
    private func constructGlassLiquidPath(amplitude: Double, xCP: Double, y: Double) -> UIBezierPath{
        let path = UIBezierPath()
        
        let initialPoint = CGPoint(x: 0.0, y: y)
        path.move(to: initialPoint)
        
        let fullLength = SCREEN_WIDTH
        let nextPoint = CGPoint(x: Double(fullLength), y: y)
        
        path.addQuadCurve(to: nextPoint, controlPoint: CGPoint(x: xCP, y: Double(initialPoint.y + 100.0)))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path.addLine(to: initialPoint)
        path.close()
        
        return path
    }
    
    
    private func getControlPointsForGlassPath(forAmplitude amplitude: Float, halfLength: Float, nextPoint: CGPoint) -> (CGPoint, CGPoint){
        
        let cp1 = CGPoint(x: nextPoint.x + CGFloat(halfLength) * 1/4, y:  CGFloat(nextPoint.y - offset))
        let cp2 = CGPoint(x: nextPoint.x - CGFloat(halfLength) * 3/4, y:  CGFloat(nextPoint.y - offset))
        return (cp1, cp2)
    }
    
    
    func addAnimation(){
        
        DispatchQueue.global().async {
            let animation = CABasicAnimation(keyPath: "path")
            animation.delegate = self
            animation.duration = 1
            animation.repeatCount = .infinity
            animation.autoreverses = true
            // Your new shape here
            animation.toValue = self.newPath.cgPath
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // The next two line preserves the final shape of animation,
            // if you remove it the shape will return to the original shape after the animation finished
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            
            DispatchQueue.main.async {
                self.add(animation, forKey: "startAnimation")
            }
        }
        
        
    }
    
    func boundsAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self
        animation.duration = 1
        animation.autoreverses = false
        // Your new shape here
        animation.toValue = CGPath(rect: UIScreen.main.bounds, transform: nil)
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
        
    }
    
    func fillFull() {
        
        DispatchQueue.global(qos: .default).async {
            let scaleAnim = self.boundsAnimation()
            
            DispatchQueue.main.async {
                let animationGroup = CAAnimationGroup.init()
                animationGroup.animations = [scaleAnim]
                self.add(scaleAnim, forKey: "fillAnimation")
            }
            
        }
    }
}

extension GlassWaterLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard let fillAnimation = (self.animation(forKey: "fillAnimation")?.isEqual(anim)) else {
            return
        }
        
        if (fillAnimation) {
            DispatchQueue.main.async {
                self.removeAllAnimations()
                self.fluidDelegate?.didFinishFilling()
            }
        }
    }
}
