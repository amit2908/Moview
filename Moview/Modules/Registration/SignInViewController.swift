//
//  ViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class SignInViewController: UIViewController {

    @IBOutlet weak var tf_username: JVFloatLabeledTextField!
    @IBOutlet weak var tf_password: JVFloatLabeledTextField!
    
    @IBOutlet weak var const_topSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        const_topSpace.constant = SCREEN_HEIGHT * 0.3
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        if ApplicationManager.sharedInstance.isValidName(testStr: tf_username.text!) && ApplicationManager.sharedInstance.isValidPassword(strPassword: tf_password.text!) {
            let token = UserDefaults.standard.value(forKey: Keys.shared.REQUEST_TOKEN) as? String ?? ""
            self.showProgress(status: "Please wait...")
            Service.shared.createSession(requestToken: token, username: tf_username.text!, password: tf_password.text!, completion: {
                self.hideProgress()
                Navigation.shared.navigateToDashboard(navigationController: self.navigationController!)
            }) { (errorCode, errorMessage) in
                self.hideProgress()
                ApplicationManager.sharedInstance.showAlertPicker(vc: self, title: "alert", buttonTitle: "Ok".localized(), message: errorMessage, handler: {})
            }
//        }
    }
    
}

