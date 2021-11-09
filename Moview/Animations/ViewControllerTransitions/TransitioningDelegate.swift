//
//  TransitioningDelegate.swift
//  Moview
//
//  Created by Shubham Ojha on 17/10/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class ModalTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    let transition: UIViewControllerAnimatedTransitioning
    
    init(withTransition transition: UIViewControllerAnimatedTransitioning) {
        self.transition = transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
