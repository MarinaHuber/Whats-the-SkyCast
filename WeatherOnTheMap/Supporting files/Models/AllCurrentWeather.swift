//
//  AllCurrentWeather.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 01/26/18.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit

/* reference to JSON indirect mapping
 protocol Encodable {
 func encode(to encoder: Encoder) throws
 }
 
 protocol Decodable {
 init(from decoder: Decoder) throws
 }
 */

struct AllCurrentWeather: Decodable {
    let count: Int
    let cities: [Cities]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case cities = "list"
    }
    
}

struct Cities: Decodable {
//    let coord: Coord
//    let sys: Sys
    let weather: [Weather]
    let main: Main
//    let wind: Wind
//    let clouds: Clouds
    let dt: Int
    let id: Int
    let name: String?
    
}

struct Coord: Decodable {
    let lon: Double?
    let lat: Double?
}

struct Sys: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: UInt64?
    let sunset: UInt64?
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

struct Wind: Decodable {
    let deg: Int?
    let speed: Double?
}

struct Clouds: Decodable {
    let all: Int?
}


