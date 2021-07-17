//
//  LiquidAnimationView.swift
//  Moview
//
//  Created by Shubham Ojha on 12/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit

enum FluidAnimationType: Int {
    case wave = 0, glassOfWater
}

protocol FluidAnimationDelegate: class {
    func didFinishFilling()
}
extension FluidAnimationDelegate {
    func didFinishFilling(){}
}

class FluidAnimationView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    // Height of the wave
    private var amplitude = 15.0
    
    // Number of h
    var frequency = 20
    
    // Legnth of one wave
    var waveLength = 120.0
    
    private var offset  = CGFloat(20.0)
    
    let shapeLayer = CAShapeLayer()
    
    private var shapePath : UIBezierPath = UIBezierPath()
    private var newPath : UIBezierPath = UIBezierPath()
    
    private(set) var animationType : FluidAnimationType
    
    
    weak var delegate : FluidAnimationDelegate?
    
    
    init(animationType type: FluidAnimationType, frame: CGRect) {
        self.animationType = type
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = UIColor.clear
        
        // initial path of the view
        
        if self.animationType == .wave {
            shapePath = constructWavePath(amplitude: amplitude)
            
            shapeLayer.path = shapePath.cgPath
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.fillColor = UIColor.red.cgColor
            layer.addSublayer(shapeLayer)
            
            offset = -offset
            // final path
            newPath = constructWavePath(amplitude: -amplitude)
        }else if self.animationType == .glassOfWater {
            
            frequency = 1
            waveLength = Double(SCREEN_WIDTH * 2)
            let yAxisMax = 30.0
            let xCP = 30.0
            shapePath = constructGlassLiquidPath(amplitude: amplitude, xCP: xCP, y: yAxisMax)
            
            shapeLayer.path = shapePath.cgPath
            //            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.fillColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
            layer.addSublayer(shapeLayer)
            
            offset = -offset
            // final path
            newPath = constructGlassLiquidPath(amplitude: amplitude, xCP: Double(SCREEN_WIDTH) - xCP, y: -yAxisMax)
        }
        
        
        
        self.addAnimation()
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
        
        let initialPoint = CGPoint(x: 0.0, y: -y)
        path.move(to: initialPoint)
        
        let halfLength = SCREEN_WIDTH
        let nextPoint = CGPoint(x: Double(halfLength), y: y)
        
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
                self.shapeLayer.add(animation, forKey: "startAnimation")
            }
        }
        
        
    }
    
    
    func fillFull() {
        
        DispatchQueue.global(qos: .default).async {
            let animation = CABasicAnimation(keyPath: "path")
            animation.delegate = self
            animation.duration = 1
            animation.autoreverses = false
            // Your new shape here
            animation.toValue = CGPath(rect: UIScreen.main.bounds, transform: nil)
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            // The next two line preserves the final shape of animation,
            // if you remove it the shape will return to the original shape after the animation finished
            //        animation.fillMode = .backwards
            animation.isRemovedOnCompletion = false
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.frame = UIScreen.main.bounds
                    self.shapeLayer.add(animation, forKey: "fillAnimation")
                }
                
                
            }
            
        }
        
    }
}

extension FluidAnimationView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard let fillAnimation = (shapeLayer.animation(forKey: "fillAnimation")?.isEqual(anim)) else {
            return
        }
        
        if (fillAnimation) {
            DispatchQueue.main.async {
                self.shapeLayer.removeAllAnimations()
                self.shapeLayer.removeFromSuperlayer()
                self.delegate?.didFinishFilling()
                self.removeFromSuperview()
            }
        }
    }
}
