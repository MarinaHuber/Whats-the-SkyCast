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

struct UserDefaultsUnitsKey {
	static let fahrenheit = "°F"
	static let celsius = "°C"

	private init() { }
}


struct Font {
	static let largeText = UIFont(name: "Servetica-Thin", size: 23)
	static let smallText = UIFont(name: "Servetica-Thin", size: 20)
	
	
	static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
		return UIFont(name: "Servetica-Thin", size: size)
	}
	
	
}
