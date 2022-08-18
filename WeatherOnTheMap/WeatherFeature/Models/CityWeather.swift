//
//  CityWeather.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 01/26/18.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation


public struct CityWeather: Codable {
    let weather: [WeatherSingle]
    let base: String
    let main: MainSingle
    let visibility: Int
    let dt: Int
    let id: Int
    var name: String
    let cod: Int

}

struct WeatherSingle: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String

}

struct MainSingle: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
}
