//
//  Keys.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

struct Keys {
    static let shared = Keys()
    
    let REQUEST_TOKEN = "requestToken"
    let ACCESS_TOKEN = "accessToken"
    
}

struct Storyboards {
    static let shared = Storyboards()
    let main = "Main"
    let signedOut = "SignedOut"
}

struct ViewControllers {
    static let shared = ViewControllers()
    let dashboard = "DashboardViewController"
    let movieDetail = "MovieDetailViewController"
    let signUp = "SignUpViewController"
    let signIn = "SignInViewController"
    let movieList = "MovieListViewController"
}
