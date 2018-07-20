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

struct Font {
	static let largeText = UIFont(name: "Servetica-Thin", size: 23)
	static let smallText = UIFont(name: "Servetica-Thin", size: 20)
	
	
	static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
		return UIFont(name: "Servetica-Thin", size: size)
	}
	
}

//
//	 // MARK: - Helper functions for temperature conversion
//    open func cToFahrenheit(tempC: Double) -> Double {
//        return (tempC * 1.8) + 32
//    }


//    func kelvinToCelsius(tempK: Double) -> Double {
//        return tempK - 273.15
//    }
//
//	open func fToC(tempF: Double) -> Double {
//		return (tempF - 32) / 1.8
//	}
//
//    // it comes in celsius units
//
//    func fixTempForDisplayFahrenheit(temp: Double) -> String {
//        print("Kelvin: \(temp)")
//        print("C: \(temp - 273.15)")
//
//        let tempC = kelvinToCelsius(tempK: temp)
//        let tempF = cToFahrenheit(tempC: tempC)
//        let tempR = Int(round(tempF))
//        let tempString = String(format: "%.0f", tempR)
//        return tempString
//    }
