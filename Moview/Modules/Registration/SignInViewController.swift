//
//  ViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    @IBOutlet weak var tf_username: MoviewTextField!
    @IBOutlet weak var tf_password: MoviewTextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    
    @IBOutlet weak var const_topSpace: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_m: UILabel!
    @IBOutlet weak var lbl_o: UILabel!
    @IBOutlet weak var lbl_v: UILabel!
    @IBOutlet weak var lbl_i: UILabel!
    @IBOutlet weak var lbl_e: UILabel!
    @IBOutlet weak var lbl_w: UILabel!
    
    
    var glassWaterLayer : GlassWaterLayer!
    
    var signInPresenter = SignInPresenter()
    var textFieldDelegate : UITextFieldDelegate!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        customizeUI()
        setDelegate()
        
        
        _ = tf_username.rx.text.map{ $0 ?? ""}.bind(to: signInPresenter.emailText)
        _ = tf_password.rx.text.map{ $0 ?? ""}.bind(to: signInPresenter.passwordText)
        _ = signInPresenter.isValid.bind(to: btn_signin.rx.isEnabled)
        
        _ = signInPresenter.isValid.subscribe(onNext: { [unowned self] (isValid) in
            self.btn_signin.alpha = isValid ? 1.0 : 0.4;
        }).disposed(by: disposeBag)
        
//        self.addLiquidView()
        self.addGlassWaterAnimation()
    }
    
    func setDelegate() {
        textFieldDelegate = SignInViewTextFieldDelegate()
        self.tf_username.delegate = textFieldDelegate
        self.tf_password.delegate = textFieldDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        const_topSpace.constant = SCREEN_HEIGHT * 0.3
//        Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateMoviewTitle()
        self.tf_username.becomeFirstResponder()
    }
    
    //MARK: Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        /*
        if ApplicationManager.sharedInstance.isValidName(testStr: tf_username.text!) && ApplicationManager.sharedInstance.isValidPassword(strPassword: tf_password.text!) {
            let token = UserDefaults.standard.value(forKey: Keys.shared.REQUEST_TOKEN) as? String
//            self.showProgress(status: "Please wait...")
            
            if (token == nil) {
//                self.liquidView.fillFull()
            }
            
           /* Service.shared.createSession(requestToken: token, username: tf_username.text!, password: tf_password.text!, completion: {
                self.hideProgress()
                Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
            }) { (errorCode, errorMessage) in
                self.hideProgress()
                ApplicationManager.sharedInstance.showAlertPicker(vc: self, title: "alert", buttonTitle: "Ok".localized(), message: errorMessage, handler: {})
            }*/
        }
        */
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        self.fillWater()
//        Navigation.shared.navigateToMainContainer(navigationController: self.navigationController!)
    }
    @IBAction func action_signUpButtonTapped(_ sender: Any) {
            Navigation.shared.navigateToSignUp(navigationController: self.navigationController!)
    }
    
    func animateMoviewTitle(){
        let operationQueue = OperationQueue()
        let animateOperation_M = BlockOperation {
            let transformAnimation = CABasicAnimation(keyPath: "transform")
            let affineTransform3D = CATransform3DMakeRotation(3.14, 0, 1, 0)
            transformAnimation.toValue = affineTransform3D
            transformAnimation.duration = 1.0
            transformAnimation.repeatCount = 1
            transformAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            
            OperationQueue.main.addOperation {
                self.lbl_m.layer.add(transformAnimation, forKey: "transformAnimation")
            }
        }
        animateOperation_M.qualityOfService = .userInteractive
        animateOperation_M.queuePriority = .high
        
        animateOperation_M.completionBlock = {
            print("M animation finished")
        }
        
        operationQueue.addOperation(animateOperation_M)
        
        let animateOperation_O = BlockOperation {
            let bounceAnimation = CABasicAnimation(keyPath: "position.y")
            bounceAnimation.toValue = -50
            bounceAnimation.duration = 0.5
            bounceAnimation.repeatCount = 1
            bounceAnimation.autoreverses = true
            bounceAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            OperationQueue.main.addOperation {
                self.lbl_o.layer.add(bounceAnimation, forKey: "bounceAnimation")
            }
        }
        
        
        operationQueue.addOperation(animateOperation_O)
        
        
    }
    

    
    func addGlassWaterAnimation(){
        glassWaterLayer = GlassWaterLayer()
        glassWaterLayer.frame = self.view.bounds
        glassWaterLayer.fluidDelegate = self
        self.view.layer.addSublayer(glassWaterLayer)
        glassWaterLayer.addAnimation()
    }
    
    func fillWater(){
        glassWaterLayer.fillFull()
    }
    
    
}

extension SignInViewController: FluidAnimationDelegate {
    func didFinishFilling() {
        self.glassWaterLayer.removeFromSuperlayer()
        Navigation.shared.navigateToMainContainer(navigationController: self.navigationController!)
    }
}
