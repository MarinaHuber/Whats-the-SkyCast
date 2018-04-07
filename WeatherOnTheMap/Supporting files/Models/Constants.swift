//
//  Constants.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit



struct ForcastBackground: Codable {
	//TO DO: add units for UserDefault?
	var cityName: String
	var cityTemperature: Double
	var cityID: Int
	
	enum CodingKeys: String, CodingKey {
		case cityName = "city"
		case cityTemperature = "city_temperature"
		case cityID = "city_id"
	}
	
	init(cityName: String, cityTemperature: Double , cityID: Int) {
		self.cityName = cityName
		self.cityTemperature = cityTemperature
		self.cityID = cityID
	}
	
	
}

enum UserDefaultsUnitsKey: String {
	case celsius = "°C"
	case fahrenheit = "°F"
}


struct Font {
	static let largeText = UIFont(name: "Servetica-Thin", size: 23)
	static let smallText = UIFont(name: "Servetica-Thin", size: 20)
	
	
	static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
		return UIFont(name: "Servetica-Thin", size: size)
	}
	
	
}
