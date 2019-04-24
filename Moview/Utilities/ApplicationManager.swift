//
//  ApplicationManager.swift
//  empowered-ios-kit
//
//  Created by Mac on 17/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

// Creating Singleton
// Only one instance of this class can be created
class ApplicationManager {
    // Declare class instance property
    static let sharedInstance = ApplicationManager()
    var userData : Any?
    
    // Declare an initializer
    // Because this class is singleton only one instance of this class can be created
    init() {
        
        print("CloudCodeExecutor has been initialized")
    }
    
    // Add a function
    func processCloudCodeOperation() {
        print("Started processing cloud code operation")
        // Your other code here
    }
    
    func showAlertPicker(vc:AnyObject, title:String, buttonTitle: String, message:String, handler: @escaping ()->() ) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .cancel) { (_) in
            handler()
        }
        alertView.addAction(cancelAction)
        vc.present(alertView, animated: false, completion:{})
    }
    
    func isValidName(testStr: String) -> Bool {
        let name = "^[\\p{L} .'-]+$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", name)
        return nameTest.evaluate(with: testStr)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isvalidPhoneNumber(value: String) -> Bool {
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$";
        let PHONE_REGEX = "^[0-9]{10,14}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isvalidPhoneNumberWithCountryCode(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$";
        //        let PHONE_REGEX = "^[0-9]{10,14}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidPincode(value: String) -> Bool {
        if value.count == 6{
            return true
        }else{
            return false
        }
    }
    
    func isValideIdNumber(value: String) -> Bool{
        if value.count == 9{
            return true
        }else{
            return false
        }
    }
    
    func isValidAccountNumber(value: String) -> Bool{
        if value.count >= 3 && value.count <= 10{
            return true
        }else{
            return false
        }
    }
    
    /*func isValidPassword(strPassword: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: strPassword)
    }*/
    
    func isValidPassword(strPassword: String) -> Bool {
        if strPassword.count <= 7 {
            return false
        }
        return true
    }
    
    func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    
    func isPwdLenth(password: String , confirmPassword : String) -> Bool {
        if password.count <= 7 && confirmPassword.count <= 7{
            return true
        }else{
            return false
        }
    }
    
    func isTextFieldEmty(value: String) -> Bool {
        if value.count == 0{
            return true
        }else{
            return false
        }
    }
    
    func isLoggedIn()-> Bool{
        if let userInfo = UserDefaults.standard.value(forKey: "kUserData") {
            if let userInfoData = NSKeyedUnarchiver.unarchiveObject(with: userInfo as! Data) {
                print(userInfoData)
                self.userData = userInfoData
            }
            return true
        }
//        else if let userInfo = UserDefaults.standard.value(forKey: "kFBUserData") {
//
//                self.userData = userInfo as! NSMutableDictionary
//
//            return true
//        } else if let userInfo = UserDefaults.standard.value(forKey: "kGmailUserData") {
//            if let userInfoData = NSKeyedUnarchiver.unarchiveObject(with: userInfo as! Data) {
//                print(userInfoData)
//                self.userData = userInfoData as! NSMutableDictionary
//            }
//            return true
//        } else if let userInfo = UserDefaults.standard.value(forKey: "kTwitterUserData") {
//            if let userInfoData = NSKeyedUnarchiver.unarchiveObject(with: userInfo as! Data) {
//                print(userInfoData)
//                self.userData = userInfoData as! NSMutableDictionary
//            }
//            return true
//        } else if let userInfo = UserDefaults.standard.value(forKey: "kAmazonUserData") {
//            if let userInfoData = NSKeyedUnarchiver.unarchiveObject(with: userInfo as! Data) {
//                print(userInfoData)
//                self.userData = userInfoData as! NSMutableDictionary
//            }
//            return true
//        }
        
        else {
            return false
        }
    }
    
    func checkCardNumber(input: String) -> (type: CardType, formatted: String, valid: Bool) {
        // Get only numbers from the input string
        
       let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        //let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(number: numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly {
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        formatted += formatted4 // the rest
        
        // return the tuple
        return (type, formatted, valid)
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        for tuple in digitStrings.enumerated() {
            guard let digit = Int(tuple.element) else { return false }
            let odd = tuple.offset % 2 == 1
            switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
            }
        }
        return sum % 10 == 0
    }
    
    enum CardType: String {
        case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
        static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
        
        var regex : String {
            switch self {
                case .Amex:
                    return "^3[47][0-9]{5,}$"
                case .Visa:
                    return "^4[0-9]{6,}([0-9]{3})?$"
                case .MasterCard:
                    return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
                case .Diners:
                    return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
                case .Discover:
                    return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
                case .JCB:
                    return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
                case .UnionPay:
                    return "^(62|88)[0-9]{5,}$"
                case .Hipercard:
                    return "^(606282|3841)[0-9]{5,}$"
                case .Elo:
                    return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
                default:
                    return ""
            }
        }
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    //Id number string formatting
    func getFormattedIdNumberString(idNumber: String) -> String{
        var modifiedIdNumber = ""
        let actualNumber = idNumber.components(separatedBy: "-").joined()
        
        if idNumber.last == "-" {
            if idNumber.count >= 3 {
                var trimmedString = actualNumber.dropLast()
                trimmedString.append("-")
                trimmedString.append(idNumber[idNumber.count-2])
                modifiedIdNumber = String(trimmedString)
            }else {
                modifiedIdNumber = actualNumber
            }
            
        }else {
            for i in 0..<idNumber.count {
                
                if (i == idNumber.count-1  &&  i > 0) {
                    modifiedIdNumber = modifiedIdNumber.components(separatedBy: "-").joined()
                    modifiedIdNumber.append("-")
                    
                }
                modifiedIdNumber.append(idNumber[i])
                
            }
        }
        return modifiedIdNumber
    }
    
    func getFormattedPhoneNumberString(idNumber: String) -> String{
        var modifiedIdNumber = ""
        let actualNumber = idNumber.components(separatedBy: "-").joined()
        
        if idNumber.last == "-" {
            if idNumber.count >= 3 {
                var trimmedString = actualNumber.dropLast()
                trimmedString.append("-")
                trimmedString.append(idNumber[idNumber.count-2])
                modifiedIdNumber = String(trimmedString)
            }else {
                modifiedIdNumber = actualNumber
            }
            
        }else {
            if idNumber.count == 3 || idNumber.count == 7 {
                modifiedIdNumber.append(idNumber)
                modifiedIdNumber.append("-")
            }
            else {
                modifiedIdNumber.append(idNumber)
            }
        }
        return modifiedIdNumber
    }
    
    func getFormattedDOBString(idNumber: String) -> String{
        var modifiedIdNumber = ""
        let actualNumber = idNumber.components(separatedBy: "/").joined()
        
        if idNumber.last == "/" {
            if idNumber.count >= 3 {
                var trimmedString = actualNumber.dropLast()
                trimmedString.append("/")
                trimmedString.append(idNumber[idNumber.count-2])
                modifiedIdNumber = String(trimmedString)
            }else {
                modifiedIdNumber = actualNumber
            }
            
        }else {
            if idNumber.count == 2 || idNumber.count == 5 {
                modifiedIdNumber.append(idNumber)
                modifiedIdNumber.append("/")
            }
            else {
                modifiedIdNumber.append(idNumber)
            }
        }
        return modifiedIdNumber
    }

}
