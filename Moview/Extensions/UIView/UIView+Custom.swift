//
//  UIView+Custom.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

var associateObjectValue: Int = 0

extension UIView {
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    @IBInspectable var layerOppacity: Float {
        get {
            return layer.opacity
        }
        set {
            
            layer.opacity = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var topRoundedCorner: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var bottomRoundedCorner: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            layer.masksToBounds = true
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue!.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable open var shadowOffsetY: CGFloat {
        set {
            layer.shadowOffset.height = newValue
        }
        get {
            return layer.shadowOffset.height
        }
    }
    
    
    func addBottomShadow(view:UIView?)  {
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: self.bounds.origin.x, y: self.frame.size.height))
        shadowPath.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height + 7.0))
        shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        shadowPath.close()
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = 5
//        let shadowSize : CGFloat = 2
//        let shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                   y: 10,
//                                                   width: self.frame.size.width,
//                                                   height: self.frame.size.height + shadowSize))
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowPath = shadowPath.cgPath
    }
    
    //MARK:- Helper Methods
    
    func addTopShadow(_ width : CGFloat = UIScreen.main.bounds.width , shadowColor: UIColor = UIColor.lightGray) {
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: CGRect(x: self.bounds.origin.x, y: self.bounds.minY - 5 , width: width, height: 10)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
        superview?.bringSubviewToFront(self)
    }
    
    func addShadowToRightAndBottom(myView : UIView, color: CGColor){
       // myView.layer.shadowColor = [UIColor purpleColor].CGColor;
        myView.layer.shadowColor = color
           myView.layer.shadowOffset = CGSize(width: 5, height: 5);
           myView.layer.shadowOpacity = 1;
           myView.layer.shadowRadius = 1.0;
           myView.layer.masksToBounds = false
    }
    
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0,
                   shadowColor: CGColor) {

        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = shadowColor
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height

        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    func addShadow(view:UIView , color : UIColor = UIColor.gray , opacity : Float = 1.0 , radius : CGFloat = 3.0 , offset : CGSize = CGSize(width: 0.0, height: 0.0))  {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
    }
    
    func addShadowProductCell(view:UIView , color : UIColor = UIColor.gray , opacity : Float = 1.0 , radius : CGFloat = 3.0 , offset : CGPoint = CGPoint(x: 0.0, y: 0.0))  {
        
        view.shadowColor = color
        view.shadowOffset = offset
        view.shadowOpacity = opacity
        view.shadowRadius = radius
    }

    
    
    func applyGradientBackground(colours: [UIColor], locations: [NSNumber]? = nil) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.name = "gradientLayer"
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        //gradient.startPoint = CGPoint(x: 1, y: 0)
        //gradient.endPoint = CGPoint(x: 0, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradientBackground(colours: [UIColor], isLeft : Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colours.map({ $0.cgColor })
        gradientLayer.locations = nil
        gradientLayer.startPoint = CGPoint(x: isLeft ? 1 : 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: isLeft ? 0 : 1, y: 0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateLayerBounds(_ name : String)
    {
        guard let layers = layer.sublayers else {
            
            return
        }
        for layer in layers
        {
            if layer.name == name {
                
                layer.frame = self.bounds
            }
        }
    }
    
    func layerWith(size: CGSize, color: UIColor, isFill : Bool) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 3
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: 0,
                    endAngle: CGFloat(2 * Double.pi),
                    clockwise: false)
        layer.fillColor = isFill ? color.cgColor : nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }
    
    //MARK:- Animation Methods
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.4, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.4,delayBy: TimeInterval = 0.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromRightTransition.beginTime = delayBy
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    
    func slideInFromBottom(duration: TimeInterval = 0.4, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromBottomTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromBottomTransition.type = CATransitionType.push
        slideInFromBottomTransition.subtype = CATransitionSubtype.fromTop
        slideInFromBottomTransition.duration = duration
        slideInFromBottomTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromBottomTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromBottomTransition, forKey: "slideInFromBottomTransition")
    }
    
    func slideInFromTop(duration: TimeInterval = 0.4, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromTopTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromTopTransition.type = CATransitionType.push
        slideInFromTopTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromTopTransition.duration = duration
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromTopTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromTopTransition, forKey: "slideInFromTopTransition")
    }
    
    func viewBottomTopDampingAnimation(){
        
        self.frame.origin.y = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .curveEaseInOut, animations: ({
            
            self.frame.origin.y = (UIApplication.currentViewController()?.view.frame.size.height)! - self.frame.size.height
            
        }), completion: nil)
    }
    
    func viewBottomOutDampingAnimation(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .curveEaseOut, animations: ({
            
            self.frame.origin.y = (UIApplication.currentViewController()?.view.frame.size.height)! + self.frame.size.height
            
        }), completion: completion)
    }

    func backgroundImageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
    
    func rotateIn3D(_ isClock: Bool) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        
        animation.fromValue = isClock ? 0 : Double.pi;
        animation.toValue = isClock ? Double.pi : 0;
        animation.repeatCount = 1;
        animation.duration = 0.7;
        
        self.layer.add(animation, forKey: "rotation")
        
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / 500.0;
        self.layer.transform = transform;
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
    /// func : rotateCircle
    /// - Parameter toValue: Animation start to value
    /// - Parameter duration: Set animation duration
    /// - Parameter  fromValue:  Animation start from value
    /// - Parameter repeatCount: Animation repeat count
    /// - Parameter axis: Axis for animation ratation
    func rotateCircle(toValue: CGFloat, fromValue:CGFloat, duration: CFTimeInterval = 2,repeatCount:Float, axis:String) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.\(axis)")
        rotateAnimation.fromValue = fromValue
        rotateAnimation.toValue = toValue
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=repeatCount
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.6
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    //MARK: Collection Cell Selection Animation
    func collectionCellSelectionAnimation(view:UIView, complection: @escaping ((Bool) ->Void)) {
        UIView.animate(withDuration: 0, animations: {
            view.backgroundColor = .lightGray
            view.cornerRadius = 5
            self.pulsate()
        }, completion: complection)
    }
    
    
    func bellRingingAnimation() {
        UIView.animate(withDuration: 0.1, delay: 1.0, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat((-5.0 * Double.pi) / 180.0))
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [.autoreverse, .repeat], animations: {
                UIView.setAnimationRepeatCount(4)
                self.transform = CGAffineTransform(rotationAngle: CGFloat((5.0 * Double.pi) / 180.0))
            }, completion: { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
        //layer.layoutSublayers()
    }
    
    //MARK:- Release Helpers for Shimmer Animation
    func removeAllAnimations()
    {
        layer.removeAllAnimations()
    }
    
    func removeAllSubViews()
    {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    static var reuseID: String {
        get{
            return String(describing: self)
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))

    }
    
    static func bundlePath() -> Bundle {
           return Bundle(for: self)
       }
    
    // MARK: - Shimmer Animation Related
    
    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }

    
    func startShimmering() {
        for animateView in getSubViewsForAnimate() {
            animateView.clipsToBounds = true
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            animateView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.5
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            animation.repeatCount = .infinity
            
            gradientLayer.add(animation, forKey: "")
        }
    }
    
    func stopShimmering() {
        for animateView in getSubViewsForAnimate() {
            animateView.layer.removeAllAnimations()
            animateView.layer.mask = nil
        }
    }
    
    func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in self.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter({ (obj) -> Bool in
            obj.shimmerAnimation
        })
    }
    
    func roundTopCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}


// ====================
// MARK: UIProgressView
// ====================
extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}

// ===================================
// MARK: CGRect center point extension
// ===================================
extension CGRect {
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
}
