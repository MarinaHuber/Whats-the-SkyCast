//
//  Constants.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit


enum Keys {
    static let APIKey: String = "c6e381d8c7ff98f0fee43775817cf6ad"
    static let base_URL = "https://api.openweathermap.org/data/2.5/"
}

enum ServiceParameters {
    static let apiKey = "apikey"
    static let hash = "hash"
    static let timestamp = "ts"
    static let offset = "offset"
}

struct Font {
	static let largeText = UIFont(name: "Servetica-Thin", size: 23)
	static let smallText = UIFont(name: "Servetica-Thin", size: 20)
	
	
	static func mainFontWithSize(_ size: CGFloat) -> UIFont?  {
		return UIFont(name: "Servetica-Thin", size: size)
	}
	
}


    // MARK: - Helper functions
func cToFahrenheit(tempC: Double) -> Double {
    return (tempC * 1.8) + 32
}


func kelvinToCelsius(tempK: Double) -> Double {
    return tempK - 273.15
}

func fToC(tempF: Double) -> Double {
    return (tempF - 32) / 1.8
}


func fixTempForDisplayFahrenheit(temp: Double) -> String {
    print("Kelvin: \(temp)")
    print("C: \(temp - 273.15)")
    
    let tempC = kelvinToCelsius(tempK: temp)
    let tempF = cToFahrenheit(tempC: tempC)
    let tempR = Int(round(tempF))
    let tempString = String(format: "%.0f", tempR)
    return tempString
}
