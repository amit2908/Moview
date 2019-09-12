//
//  ViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    @IBOutlet weak var tf_username: JVFloatLabeledTextField!
    @IBOutlet weak var tf_password: JVFloatLabeledTextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    
    @IBOutlet weak var const_topSpace: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_m: UILabel!
    @IBOutlet weak var lbl_o: UILabel!
    @IBOutlet weak var lbl_v: UILabel!
    @IBOutlet weak var lbl_i: UILabel!
    @IBOutlet weak var lbl_e: UILabel!
    @IBOutlet weak var lbl_w: UILabel!
    
    var singInViewModel = SignInViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = tf_username.rx.text.map{ $0 ?? ""}.bind(to: singInViewModel.emailText)
        _ = tf_password.rx.text.map{ $0 ?? ""}.bind(to: singInViewModel.passwordText)
        _ = singInViewModel.isValid.bind(to: btn_signin.rx.isEnabled)
        
        _ = singInViewModel.isValid.subscribe(onNext: { [unowned self] (isValid) in
            self.btn_signin.alpha = isValid ? 1.0 : 0.4;
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        const_topSpace.constant = SCREEN_HEIGHT * 0.3
//        Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateMoviewTitle()
    }
    
    //MARK: Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        Navigation.shared.navigateToDashboard(navigationController:self.navigationController!)
        if ApplicationManager.sharedInstance.isValidName(testStr: tf_username.text!) && ApplicationManager.sharedInstance.isValidPassword(strPassword: tf_password.text!) {
            let token = UserDefaults.standard.value(forKey: Keys.shared.REQUEST_TOKEN) as? String
//            self.showProgress(status: "Please wait...")
            
            if (token == nil) {
                Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
            }else {
                
            }
            
           /* Service.shared.createSession(requestToken: token, username: tf_username.text!, password: tf_password.text!, completion: {
                self.hideProgress()
                Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
            }) { (errorCode, errorMessage) in
                self.hideProgress()
                ApplicationManager.sharedInstance.showAlertPicker(vc: self, title: "alert", buttonTitle: "Ok".localized(), message: errorMessage, handler: {})
            }*/
        }
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
    
}

