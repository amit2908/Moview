//
//  AnimatedLaunchScreenViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 13/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import Lottie

class AnimatedLaunchScreenViewController: UIViewController {

    private var animationView : AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.addLottieView()
    }
   
    func addLottieView(){
        animationView = AnimationView(name: "22219-play-the-guitar")
        animationView?.animationSpeed = 0.5
        
        let frameSize : CGSize = self.view.frame.size
        animationView?.frame = UIDevice.current.orientation.isPortrait ? CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height * 0.6) :
            CGRect(x: 0, y: 0, width: frameSize.height, height: frameSize.width * 0.6)
        animationView?.center = self.view.center
        animationView?.contentMode = .scaleAspectFill
        view.addSubview(animationView!)
        animationView?.play { complete in
            if complete {
                if let loggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool, loggedIn {
                    Navigation.shared.navigateToMainContainer(navigationController: self.navigationController!)
                }else {
                    Navigation.shared.navigateToSignIn(navigationController: self.navigationController!)
                }
            }
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         animationView?.removeFromSuperview()
         self.addLottieView()
    }
    
    
}
