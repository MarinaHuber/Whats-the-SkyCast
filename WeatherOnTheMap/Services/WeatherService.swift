//
//  WeatherService.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 12/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation


enum ResultType<T> {
    case success(T)
	case failure(Error)
}

enum APIRouter {

	static let APIKey: String = "c6e381d8c7ff98f0fee43775817cf6ad"
	static let base_URL = "https://api.openweathermap.org/data/2.5/"
}


//  1. create basic request without making the object first with URLString
//  2. getCurrenWeather is after made the object
//  The limit of locations is 20: treated as 6 API calls for 6 city IDs
//  &units=metric url added GET for Celsius units temp

class WeatherService {


	public static func getCurrentWeather(_ completionHandler: @escaping (_ result: ResultType<[Cities]>) -> ()) {
		let urlString = String("\(APIRouter.base_URL)group?id=2172797,2643743,1016666,524901,703448,1851632&units=metric&appid=\(APIRouter.APIKey)")
		guard let url = URL(string: urlString) else { return }

		URLSession.shared.dataTask(with: url) { (data, response, err) in
			if let error = err {
				print("To the user what error" , error.localizedDescription)
				return
			}

			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				if #available(iOS 10.0, *) {
					decoder.dateDecodingStrategy = .iso8601
				} else {
					// Fallback on earlier versions
					decoder.dateDecodingStrategy = .secondsSince1970
				}
				let currentWeatherDecoded = try decoder.decode(AllCurrentWeather.self, from: data)
				print(currentWeatherDecoded)

				DispatchQueue.main.async() {
					completionHandler(.success(currentWeatherDecoded.cities!))
				}

			} catch {
				completionHandler(.failure(error))
				print("Error serializing json:", error)
			}

		}.resume()
	}


	public static func getOneCity(_ city: String, completionHandler: @escaping (_ result: ResultType<SingleCurrentWeather>) -> ()) {
		let urlString = String("\(APIRouter.base_URL)/weather?q=" + (city.replacingOccurrences(of: " ", with: "%20")) + "&units=metric&appid=\(APIRouter.APIKey)")
		guard let url = URL(string: urlString) else { return }
		URLSession.shared.dataTask(with: url) { (data, response, err) in
			if let error = err {
				print("Task error:" , error.localizedDescription)
				return
			}
			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				if #available(iOS 10.0, *) {
					decoder.dateDecodingStrategy = .iso8601
				} else {
					decoder.dateDecodingStrategy = .secondsSince1970
				}

				let currentForecastDecoded = try decoder.decode(SingleCurrentWeather.self, from: data)
				DispatchQueue.main.async(execute: {
				completionHandler(.success(currentForecastDecoded))
				})
			} catch let error {
				print("Error serializing json:", error)
				completionHandler(.failure(error))
				DispatchQueue.main.async(execute: {
					if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
                        if let code = json["cod"] as? String {
							if code != "200" {
                                if let message = json["message"] as? String {
									print( "To the user text: ", message.localizedUppercase)

								}
								return
							}
						}
					}
				})




			}
			}.resume()
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



    



