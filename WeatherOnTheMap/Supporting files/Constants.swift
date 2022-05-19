//
//  Constants.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let APIKey = ""

}

struct BackgroundColors {
    static let gray = UIColor.gray
    static let blue = UIColor.blue
    
}

struct Font {
    static let iPadText = UIFont(name: "Servetica-Thin", size: 23)
    static let iPhoneText = UIFont(name: "Servetica-Thin", size: 20)
    
    
    static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
        return UIFont(name: "Servetica-Thin", size: size)
    }
   

}
