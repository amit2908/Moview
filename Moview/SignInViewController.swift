//
//  ViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

