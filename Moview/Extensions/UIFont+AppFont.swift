//
//  FontExtensions.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

// Text styles
extension UIFont {
    class var headlineTextXL: UIFont {
        return UIFont(name: "PoetiAAA", size: 20.0)!
    }
    class var headlineTextLarge: UIFont {
        return UIFont(name: "PoetiAAA", size: 18.0)!
    }
    class var systemFontRegular: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .regular)
    }
    class var systemFontMedium: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    class var systemFontXXL: UIFont {
        return UIFont.systemFont(ofSize: 36.0, weight: .regular)
    }
    class var fontMedium: UIFont {
        return UIFont(name: "PoetiAAA", size: 16.0)!
    }
    
    //MARK: REGULAR fonts
    
    class var appFontRegular12: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 12.0)!
    }
    
    class var appFontRegular14: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 14.0)!
    }
    
    class var appFontRegular16: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 16.0)!
    }
    class var appFontRegular18: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 18.0)!
    }
    class var appFontRegular20: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 20.0)!
    }
    class var appFontRegular22: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 22.0)!
    }
    
    class var appFontRegular24: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 24.0)!
    }
    
    class var appFontRegular28: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 28.0)!
    }
    
    class var appFontRegular40: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 40.0)!
    }
    
    class var appFontRegular50: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 50.0)!
    }
    
    class var appFontRegular60: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 60.0)!
    }
    
    class var appFontRegular85: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Regular"), size: 85.0)!
    }
    
    
    //MARK: bold fonts
    
    class var appFontBold12: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 12.0)!
    }
    
    class var appFontBold14: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 14.0)!
    }
    
    class var appFontBold16: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 16.0)!
    }
    class var appFontBold18: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 18.0)!
    }
    class var appFontBold20: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 20.0)!
    }
    class var appFontBold25: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 25.0)!
    }
    
    class var appFontBold24: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 24.0)!
    }
    
    class var appFontBold28: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 28.0)!
    }
    
    class var appFontBold40: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 40.0)!
    }
    
    class var appFontBold50: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 50.0)!
    }
    
    class var appFontBold85: UIFont {
        return UIFont(name: String(describing: "\(APP_FONT_NAME)-Bold"), size: 85.0)!
    }
    
    class var paleGreyTwo: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
    }
    
    //    class var placeholder: UIFont {
    //        return UIFont(name: "Heebo-Light", size: 16.0)!
    //    }
    //    class var invalidName: UIFont {
    //        return UIFont(name: "Heebo-Light", size: 16.0)!
    //    }
    //    class var invalidName: UIFont {
    //        return UIFont(name: "Heebo-Regular", size: 12.0)!
    //    }
}
