//
//  SignInViewTextFieldDelegate.swift
//  Moview
//
//  Created by Shubham Ojha on 05/10/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class SignInViewTextFieldDelegate: NSObject, UITextFieldDelegate {
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
