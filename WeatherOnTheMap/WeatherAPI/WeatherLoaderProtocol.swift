//
//  WeatherLoaderProtocol.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 18.08.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation

public protocol WeatherLoaderProtocol {
    typealias Result = Swift.Result<CityWeather, Error>

    func request<T: Decodable>(_ endpoint: WeatherEndpoint, model: T.Type, completion: @escaping (Result)  -> ())
}
