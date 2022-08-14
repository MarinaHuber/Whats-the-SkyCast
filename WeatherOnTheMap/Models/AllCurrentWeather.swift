//
//  AllCurrentWeather.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 01/26/18.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation


struct AllCurrentWeather: Decodable {
	let count: Int
	let cities: [City]?

	enum CodingKeys: String, CodingKey {
		case count = "cnt"
		case cities = "list"
	}

}

struct City: Decodable {
	let weather: [Weather]
	let main: Main
	let id: Int?
	let name: String?

}

struct Weather: Decodable {
	let id: Int?
	let main: String?
	let description: String?
	let icon: String?

}

struct Main: Decodable {
	let temp: Double?
	let pressure: Double?
	let humidity: Int?
	let temp_max: Double?
	let temp_min: Double?

}
