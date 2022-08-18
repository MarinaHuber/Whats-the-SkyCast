//
//  WeatherService.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 12/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation

public final class WeatherServiceLoader: WeatherLoaderProtocol {

    public enum Error: Swift.Error {
        case responseError
        case parseError
    }

    public func request<T: Decodable>(_ endpoint: WeatherEndpoint, model: T.Type, completion:  @escaping (WeatherLoaderProtocol.Result) -> ()) {
        guard let url = endpoint.url else {
            return completion(.failure(Error.responseError))
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(.failure(Error.responseError))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(Error.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(Error.responseError))
                return
            }
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let model                       = try decoder.decode(T.self, from: data)

                guard let model                 = model as? CityWeather else { return }

                completion(.success(model))
            } catch {
                completion(.failure(Error.parseError))
            }
        }
        task.resume()
    }

// MARK: - Helper functions
	func changeUTCtoDayOfWeek(timeStamp: Int) -> String{
		let date = NSDate(timeIntervalSince1970: Double(timeStamp))

		let formatter = DateFormatter()
		formatter.dateStyle = DateFormatter.Style.short
		formatter.dateFormat = "EEEE"
		let str = formatter.string(from: date as Date)
		return str
	}




    
    }



    



