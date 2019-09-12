//
//  SignInViewModel.swift
//  Moview
//
//  Created by Empower on 12/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SignInViewModel{
    var emailText    = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
    var isValid : Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()){ email, password in
            email.count >= 3 && password.count >= 8
        }
    }
}
