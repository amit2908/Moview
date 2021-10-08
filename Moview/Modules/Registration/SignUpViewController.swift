//
//  SignUpViewController.swift
//  Moview
//
//  Created by Empower on 12/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tf_username: MoviewTextField!
    @IBOutlet weak var tf_password: MoviewTextField!
    @IBOutlet weak var tf_repeatPassword: MoviewTextField!
    @IBOutlet weak var tf_emailOrPhone: MoviewTextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.borderColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .systemPink
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
