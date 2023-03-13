//
//  NavigationBehaviour.swift
//  Moview
//
//  Created by Shubham Ojha on 17/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import UIKit

protocol Popable: UIViewController {
    func pop()
}
extension Popable{
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
}


protocol Dismissable: UIViewController {
    func dismiss(completion: (() -> Void)?)
}
extension Dismissable{
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
}
