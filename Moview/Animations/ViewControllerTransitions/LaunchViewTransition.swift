//
//  LaunchViewTransition.swift
//  Pey
//
//  Created by Empower on 10/04/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import UIKit

class LaunchViewTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate{
    let duration = 0.5
    let delayBtwAnimations = 0.25
    var presenting = true
    var originFrame = CGRect.zero
    
    public var initialScaleValue : Float = 0.0
    public var finalScaleValue : Float = 1.0
    
    
    var transitionContext : UIViewControllerContextTransitioning?
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration + delayBtwAnimations
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        
        guard let logo = fromView.subviews.count >= 3 ? fromView.subviews[2] : nil else {
            return
        }
        
        let animationGroup = CAAnimationGroup()
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animationGroup.delegate = self
        animationGroup.animations = [createScaleAnimation(initialValue: 1.0, finalValue: 20.0)] // 0.5 seconds
        
        DispatchQueue.main.async {
            logo.layer.add(animationGroup, forKey: "ScaleAnimation")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayBtwAnimations) {
            containerView.addSubview(toView)
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func createScaleAnimation(initialValue: Float, finalValue: Float) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = initialValue
        scaleAnimation.byValue = finalValue
        scaleAnimation.duration = duration
        scaleAnimation.autoreverses = false
        scaleAnimation.repeatCount = 1
        
        scaleAnimation.isRemovedOnCompletion = false
        
        return scaleAnimation
    }
    
    private func createFadeAnimation(initialValue: Float, finalValue: Float) -> CABasicAnimation {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = initialValue
        fadeAnimation.byValue = finalValue
        fadeAnimation.duration = duration
        fadeAnimation.autoreverses = false
        fadeAnimation.repeatCount = 1
        
        fadeAnimation.isRemovedOnCompletion = false
        
        return fadeAnimation
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
