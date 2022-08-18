//
//  UserDefaults+.swift
//  WeatherOnTheMap
//
//  Created by Amit Kumar Swami on 25/3/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import Foundation


extension UserDefaults {
    private static let citiesKey = "citiesKey"
    
    var cities: [CurrentWeatherMapper] {
        get {
            let decoder = JSONDecoder()
            if let data = value(forKey: UserDefaults.citiesKey) as? Data,
                let cities = try? decoder.decode([CurrentWeatherMapper].self, from: data) {
                return cities
            }
            return[]
        }
        
        set(cities) {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(cities) {
                set(data, forKey: UserDefaults.citiesKey)
            }
        }
    }
}
