//
//  FadeModalTransition.swift
//  Moview
//
//  Created by Shubham Ojha on 17/10/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class FadeModalTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate{
    let duration = 0.5
    var presenting = true
    
    public var initialScaleValue : Float = 0.0
    public var finalScaleValue : Float = 1.0
    
    
    var transitionContext : UIViewControllerContextTransitioning?
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
        
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = false
        return self
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView

        if (self.presenting) {
            guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 1
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        } else {
            guard let toViewController = transitionContext.viewController(forKey: .to),
                let fromViewController = transitionContext.viewController(forKey: .from) else { return }
            
            UIView.animate(withDuration: duration, animations: {
                fromViewController.view.alpha = 1
                toViewController.view.alpha = 0.5
            }, completion: { _ in
                transitionContext.completeTransition(true)
                UIApplication.shared.keyWindow?.addSubview(fromViewController.view)
            })
        }
        
    }
}

