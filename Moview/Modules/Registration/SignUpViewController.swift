//
//  SignUpViewController.swift
//  Moview
//
//  Created by Empower on 12/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tf_username: JVFloatLabeledTextField!
    @IBOutlet weak var tf_password: JVFloatLabeledTextField!
    @IBOutlet weak var tf_repeatPassword: JVFloatLabeledTextField!
    @IBOutlet weak var tf_emailOrPhone: JVFloatLabeledTextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_signup(_ sender: Any) {
        
    }
    
    @IBAction func action_signin(_ sender: Any) {
        Navigation.shared.navigateToSignIn(navigationController: self.navigationController!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
