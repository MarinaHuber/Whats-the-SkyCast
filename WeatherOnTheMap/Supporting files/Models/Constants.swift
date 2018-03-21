//
//  Constants.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit



struct ForcastBackground {
    
    var city: String
	var cityTemperature: Double
	var cityID: Int
	//var backgroundColor: UIColor
    
	init(city: String, cityTemperature: Double , cityID: Int /* , backgroundColor: UIColor*/ ) {
        self.city = city
		self.cityTemperature = cityTemperature
		self.cityID = cityID
		//self.backgroundColor = backgroundColor
    }
    
  
}



struct Font {
    static let largeText = UIFont(name: "Servetica-Thin", size: 23)
    static let smallText = UIFont(name: "Servetica-Thin", size: 20)
    
    
    static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
        return UIFont(name: "Servetica-Thin", size: size)
    }
   

}
