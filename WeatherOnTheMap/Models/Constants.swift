//
//  Constants.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit


struct Background {
    
    var city: String
    var backgroundColor: UIColor
    
    init(city: String, backgroundColor: UIColor) {
        self.city = city
        self.backgroundColor = backgroundColor
    }
    
  
}

struct Font {
    static let iPadText = UIFont(name: "Servetica-Thin", size: 23)
    static let iPhoneText = UIFont(name: "Servetica-Thin", size: 20)
    
    
    static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
        return UIFont(name: "Servetica-Thin", size: size)
    }
   

}
