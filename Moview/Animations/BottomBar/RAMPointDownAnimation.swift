//
//  BottomBarAnimation.swift
//  Pey
//
//  Created by Empower on 09/04/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class RAMPointDownAnimation:RAMItemAnimation {
    
    public var animationDuration : TimeInterval = 0.4
    
    public var initialRotationValue : Float = -1.0
    public var finalRotationByValue : Float = 1.0
    
    
    public var initialScaleValue : Float = 1.0
    public var finalScaleValue : Float = 1.3
    
    public var initialtranslationValue : Float = 0.0
    public var finalTranslationValue : Float = 20.0
    
    private var animationGroup: CAAnimationGroup!
    
    open override func playAnimation(_ imageView : UIImageView, textLabel lbl : UILabel) {
        
        DispatchQueue.global(qos: .default).async {
            self.setupAnimation()
            DispatchQueue.main.async {
                self.selectedState(imageView, textLabel: lbl)
                imageView.layer.add(self.animationGroup, forKey: "cameraAnimation")
                
                let animationGroup = CAAnimationGroup()
                animationGroup.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
                animationGroup.animations = [self.createFadeAnimation()]
//                imageView.layer.add(animationGroup, forKey: "secondAnimation")
                
//                let rotationAnimation = self.createRotationAnimation()
//                imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
            }
        }
        
    }
    
    private func setupAnimation() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = self.animationDuration
        self.animationGroup.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        self.animationGroup.animations = [createTranslationAnimation()]
        self.animationGroup.repeatCount = 3
    }
    
    private func createRotationAnimation() -> CABasicAnimation {
        let partialRotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        partialRotationAnimation.fromValue = self.initialRotationValue
        partialRotationAnimation.toValue = self.finalRotationByValue
        
        partialRotationAnimation.autoreverses = true
        partialRotationAnimation.repeatCount = 1
        
        partialRotationAnimation.isRemovedOnCompletion = false
        return partialRotationAnimation
    }
    
    private func createTranslationAnimation() -> CABasicAnimation {
        let translationAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        translationAnimation.fromValue = self.initialtranslationValue
        translationAnimation.byValue = self.finalTranslationValue
        
        translationAnimation.autoreverses = false
        translationAnimation.isRemovedOnCompletion = false
        
        return translationAnimation
    }
    
    private func createFadeAnimation() -> CABasicAnimation {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        
        fadeAnimation.autoreverses = true
        fadeAnimation.repeatCount = 1
        
        fadeAnimation.isRemovedOnCompletion = false
        
        return fadeAnimation
    }
    
    private func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = self.initialScaleValue
        scaleAnimation.byValue = self.finalScaleValue
        scaleAnimation.duration = animationDuration/2
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 1
        
        scaleAnimation.isRemovedOnCompletion = false
        
        return scaleAnimation
    }
    
    private func createCaptureAnimation() -> CABasicAnimation {
        let captureAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        captureAnimation.fromValue = self.initialScaleValue
        captureAnimation.byValue = self.finalScaleValue
        
        captureAnimation.autoreverses = true
        captureAnimation.repeatCount = 1
        
        captureAnimation.isRemovedOnCompletion = false
        
        return captureAnimation
    }
    
    /**
     Start animation, method call when UITabBarItem is unselected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     - parameter defaultTextColor: default UITabBarItem text color
     - parameter defaultIconColor: default UITabBarItem icon color
     */
    open override func deselectAnimation(_ imageView: UIImageView, textLabel lbl: UILabel, defaultTextColor txtColor: UIColor, defaultIconColor iconColor: UIColor) {
        imageView.image = imageView.image!.withRenderingMode(.alwaysOriginal)
        lbl.textColor = txtColor
    }
    
    
    override func selectedState(_ imageView: UIImageView, textLabel lbl: UILabel) {
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = self.iconSelectedColor
        lbl.textColor = self.textSelectedColor
    }
    

}
