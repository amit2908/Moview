//
//  Color.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

/*------------------------------------------------------------------------------------------------------------
 Color and Design Extensions
 ------------------------------------------------------------------------------------------------------------*/

// Color palette
extension UIColor {
    @nonobjc class var darkCoral: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lightishRed: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 64.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var softBlue: UIColor {
        return UIColor(red: 83.0 / 255.0, green: 148.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var steel: UIColor {
        return UIColor(red: 119.0 / 255.0, green: 122.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var aquaMarine: UIColor {
        return UIColor(red: 78.0 / 255.0, green: 206.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var slateGrey: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 91.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var cornflower: UIColor {
        return UIColor(red: 110.0 / 255.0, green: 124.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 170.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var salmon: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 126.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var palePurple: UIColor {
        return UIColor(red: 157.0 / 255.0, green: 160.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 235.0 / 255.0, green: 237.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 218.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var orangeyRed: UIColor {
        return UIColor(red: 1.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var deepSkyBlue: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var tangerine: UIColor {
        return UIColor(red: 1.0, green: 149.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    @nonobjc class var marigold: UIColor {
        return UIColor(red: 1.0, green: 204.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    @nonobjc class var weirdGreen: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var robinSEgg: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 200.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var warmBlue: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 86.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var reddishPink: UIColor {
        return UIColor(red: 1.0, green: 45.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    @nonobjc class var paleLilac: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 229.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lightBlueGrey: UIColor {
        return UIColor(red: 209.0 / 255.0, green: 209.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var royal5: UIColor {
        return UIColor(red: 10.0 / 255.0, green: 10.0 / 255.0, blue: 120.0 / 255.0, alpha: 0.05)
    }
    @nonobjc class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    @nonobjc class var darkSlateBlue7: UIColor {
        return UIColor(red: 25.0 / 255.0, green: 25.0 / 255.0, blue: 100.0 / 255.0, alpha: 0.07)
    }
    @nonobjc class var darkNavyBlue22: UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 25.0 / 255.0, alpha: 0.22)
    }
    @nonobjc class var darkSlateBlue18: UIColor {
        return UIColor(red: 25.0 / 255.0, green: 25.0 / 255.0, blue: 100.0 / 255.0, alpha: 0.18)
    }
    @nonobjc class var eggplant45: UIColor {
        return UIColor(red: 4.0 / 255.0, green: 4.0 / 255.0, blue: 15.0 / 255.0, alpha: 0.45)
    }
    @nonobjc class var blueGrey50: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.5)
    }
    @nonobjc class var lightNavyBlue: UIColor {
        return UIColor(red: 41.0 / 255.0, green: 73.0 / 255.0, blue: 127.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var vibrantPurple: UIColor {
        return UIColor(red: 168.0 / 255.0, green: 13.0 / 255.0, blue: 192.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var greenishTeal: UIColor {
        return UIColor(red: 63.0 / 255.0, green: 201.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var midBlue: UIColor {
        return UIColor(red: 38.0 / 255.0, green: 93.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
    }
    
    /*------------------------------------------------------------------------------------------------------------
     App Based Color
     ------------------------------------------------------------------------------------------------------------*/
    //Shadow color
    @nonobjc class var appShadowColor: UIColor {
        return UIColor(red: 32.0 / 255.0, green: 49.0 / 255.0, blue: 77.0 / 255.0, alpha: 0.30)
    }
    
    
}
