//
//  Pulse.swift
//  Pey
//
//  Created by Empower on 08/04/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import UIKit

class Pulse: CALayer, CAAnimationDelegate {
    
    public var animationDuration : TimeInterval = 0.0
    public var radius : CGFloat = 30
    public var initialPulseScale : Float = 0
    public var nextPulseAfter: TimeInterval = 0
    public var numberOfPulses: Float = Float.infinity
    
    private var animationGroup = CAAnimationGroup()
    
    override init() {
        super.init()
    }
    
    init(radius: CGFloat, numberOfPulses:Float = Float.infinity, position: CGPoint) {
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.animationDuration = duration
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        self.bounds = CGRect(x: 0, y: 0, width: self.radius * 2, height: self.radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
        
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0.0, 0.2, 1.0]
        opacityAnimation.values = [1.0, 0.5, 0.0]
        opacityAnimation.duration = 0.5
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return opacityAnimation
    }
    
    private func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup.init()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.timingFunction = defaultCurve
        
        animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ANIMATION DELEGATE METHODS
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            self.removeFromSuperlayer()
        }
    }
}
