//
//  CurrentWeatherMapper.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 17.08.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation


struct CurrentWeatherMapper: Codable {
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
