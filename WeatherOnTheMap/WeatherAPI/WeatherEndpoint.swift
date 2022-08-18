//
//  WeatherEndpoint.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 17.08.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation


public struct WeatherEndpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension WeatherEndpoint {
    static func getDefault() -> Self {
        return WeatherEndpoint(
            path: "/data/2.5/group",
            queryItems:  [
                URLQueryItem(name: "id", value: "2643743,1016666,524901,703448,1851632"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: Keys.APIKey)
            ]
        )
    }
    
    static func search(matching query: String) -> Self {
        return WeatherEndpoint(
            path: "/data/2.5/weather",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: Keys.APIKey)
            ]
        )
    }
}

extension WeatherEndpoint {
    var url: URL? {
        var components        = URLComponents()
        components.scheme     = "https"
        components.host       = "api.openweathermap.org"
        components.path       = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

