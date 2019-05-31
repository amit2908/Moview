//
//  Extensions.swift
//  Pey
//
//  Created by Empower on 12/02/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import UIKit
import SVProgressHUD

enum AppFontWeight {
    case bold
    case regular
    case semibold
}


extension UILabel {
    func setAutoResizablefontSize(fontSize: CGFloat, name: String?, weight: AppFontWeight?){
        let screenWidthMultiplier = 375.0 / ((UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.width ?? 375.0)
        let size = fontSize * screenWidthMultiplier
        if let fontName = name {
            if let fontWeight = weight {
               self.font = UIFont(name:  "\(fontName)-\(fontWeight)" , size: size) ?? UIFont.systemFont(ofSize: fontSize)
            }else {
                self.font = UIFont(name:  "\(fontName)-Regular" , size: size)
            }
        }else {
               self.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}


extension UITextField {
    func setAutoResizablefontSize(fontSize: CGFloat, name: String?, weight: AppFontWeight?){
        let screenWidthMultiplier = 375.0 / ((UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.width ?? 375.0)
        let size = fontSize * screenWidthMultiplier
        if let fontName = name {
            if let fontWeight = weight {
                self.font = UIFont(name:  "\(fontName)-\(fontWeight)" , size: size) ?? UIFont.systemFont(ofSize: fontSize)
            }else {
                self.font = UIFont(name:  "\(fontName)-Regular" , size: size)
            }
        }else {
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension UITextView {
    func setAutoResizablefontSize(fontSize: CGFloat, name: String?, weight: AppFontWeight?){
        let screenWidthMultiplier = 375.0 / ((UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.width ?? 375.0)
        let size = fontSize * screenWidthMultiplier
        if let fontName = name {
            if let fontWeight = weight {
                self.font = UIFont(name:  "\(fontName)-\(fontWeight)" , size: size) ?? UIFont.systemFont(ofSize: fontSize)
            }else {
                self.font = UIFont(name:  "\(fontName)-Regular" , size: size)
            }
        }else {
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




extension UIViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: "alertText".localized(), message: "contactAccessText".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "openSettingsText".localized(), style: .default) { action in
            completionHandler(false)
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "cancelText".localized(), style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
    
   /* func setButtonPropertiesFor(firstButton: SubmitButton, secondButton: SubmitButton, thirdButton: SubmitButton) {
        
        firstButton.backgroundColor = Theme.AppPrimaryTextColor_lightNavyBlue
        secondButton.backgroundColor = .white
        thirdButton.backgroundColor  = .white
        
        firstButton.setTitleColor(.white, for: .normal)
        secondButton.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
        thirdButton.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
        
//        firstButton.setBorderAndTintColor()
    }
    
    func setButtonPropertiesForSend(firstButton: SubmitButton, secondButton: SubmitButton, thirdButton: SubmitButton, fourthButton: SubmitButton) {
        
        firstButton.backgroundColor = Theme.AppPrimaryTextColor_lightNavyBlue
        secondButton.backgroundColor = .white
        thirdButton.backgroundColor  = .white
        fourthButton.backgroundColor  = .white
        
        firstButton.setTitleColor(.white, for: .normal)
        secondButton.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
        thirdButton.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
        fourthButton.setTitleColor(Theme.AppTertiaryTextColor_brownG, for: .normal)
        
//        firstButton.setBorderAndTintColor()
    }*/
    
    @objc func gotoMainScreen(sender: UIButton){
        //Navigate to enter amount screen
//        let mainContainerVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MainContainerViewController") as? MainContainerViewController
//        self.show(mainContainerVC!, sender: self)
    }
    
    @objc func backButtonAction(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showProgress(status: String) {
        // Set ProgressHUD mask type
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show(withStatus: status)
    }
    
    func showProgressWithImage(image: UIImage, status: String) {
        //SVProgressHUD.setInfoImage(image)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setInfoImage(image)
        SVProgressHUD.show(image, status: status)
    }
    
    func hideProgress() {
        
        SVProgressHUD.dismiss()
    }
}


public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
