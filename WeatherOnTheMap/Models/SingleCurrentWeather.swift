//
//  SingleCurrentWeather.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 03/23/18.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit


struct SingleCurrentWeather: Decodable {
	let coord: Cordinates
	let weather: [WeatherSingle]?
	let base: String?
	let main: MainSingle?
	let visibility: Int?
	let wind: WindSingle?
	let clouds: CloudsSingle?
	let dt: Int?
	let sys: System?
	let id: Int?
	let name: String?
	let cod: Int?


}


struct WeatherSingle: Decodable {
	let id: Int?
	let main: String?
	let description: String?
	let icon: String?

}

struct Cordinates: Decodable {
	let lon: Double?
	let lat: Double?
}

struct System: Codable {
	let type: Int?
	let id: Int?
	let message: Double?
	let country: String?
	let sunrise: UInt64?
	let sunset: UInt64?
}


struct MainSingle: Decodable {

	let temp: Double?
	let pressure: Double?
	let humidity: Int?
	let temp_max: Double?
	let temp_min: Double?

}

struct WindSingle: Decodable {
	let deg: Double?
	let speed: Double?
}

struct CloudsSingle: Decodable {
	let all: Int?
}



