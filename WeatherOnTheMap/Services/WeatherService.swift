//
//  WeatherService.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 12/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
//import UIKit

//protocol WeatherServiceDelegate {
//    func setWeather(weather: AllCurrentWeather)
//    func weatherErrorWithMessage(message: String)
//}


// TODO:check Daniel notes on generics
enum ResultType<T> {
    case success(T)
	case failure(Error)
}

enum APIRouter {

	static let APIKey: String = "c6e381d8c7ff98f0fee43775817cf6ad"
	static let base_URL = "http://api.openweathermap.org/data/2.5/"
}


//  1. create basic request without making the object first
//  2. getCurrenWeather is after made the object
//  The limit of locations is 20: treated as 6 API calls for 6 city IDs
//  &units=metric url added GET for Celsius units temp
class WeatherService {


	public static func getCurrentWeatherFix(_ completionHandler: @escaping (_ result: ResultType<[Cities]>) -> ()) {
		let urlString = String("\(APIRouter.base_URL)group?id=2172797,2643743,1016666,524901,703448,1851632&units=metric&appid=\(APIRouter.APIKey)")
		guard let url = URL(string: urlString) else { return }

		URLSession.shared.dataTask(with: url) { (data, response, err) in
			if let error = err {
				print("To the user" , error.localizedDescription)
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




	//ADD _ result: ResultType<[SingleCurrentWeather]>
	//  URLSession can return a response and an error at the same time
	//https://oleb.net/blog/2018/03/making-illegal-states-unrepresentable/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B345

	public static func getCityWeather(_ city: String, completionHandler: @escaping (_ cityCurrent: SingleCurrentWeather, _ error: Error?) -> ()) {
		let urlString = String("\(APIRouter.base_URL)/weather?q=" + (city.replacingOccurrences(of: " ", with: "%20")) + "&units=metric&appid=\(APIRouter.APIKey)")

		// http://api.openweathermap.org/data/2.5/weather?q=montreal/&units=metric&appid=c6e381d8c7ff98f0fee43775817cf6ad

		guard let url = URL(string: urlString) else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
			if let error = err {
				/// completion(nil, error)
				print("To the user" , error.localizedDescription)
				return
			}
			guard let data = data else {
				/// handle
				return
			}
			do {
				let decoder = JSONDecoder()
				if #available(iOS 10.0, *) {
					decoder.dateDecodingStrategy = .iso8601
				} else {
					decoder.dateDecodingStrategy = .secondsSince1970
				}
				if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
					print("JSON", json ?? "")
					if let code = json?["cod"] as? String {
						if code != "200" {
							if let message = json?["message"] as? String {
								print( "To the user: ", message.capitalized)
							}
							return
						}
					}
				}
				let currentForecastDecoded = try decoder.decode(SingleCurrentWeather.self, from: data)
				DispatchQueue.main.async(execute: {
					completionHandler(currentForecastDecoded, nil)
     //					completionHandler(.success(currentForecastDecoded), nil)
				})
			} catch let jsonErr {
	//					completionHandler(.failure(currentForecastDecoded), err)
				print("Error serializing json:", jsonErr)
			}
		}
		task.resume()
	}








	public static func getCurrentWeatherAll(_ completionHandler: @escaping (_ error: Error?, _ cities: [Cities] ) -> ()) {
		let urlString = String("\(APIRouter.base_URL)group?id=2172797,2643743,1016666,524901,703448,1851632&units=metric&appid=\(APIRouter.APIKey)")
		// print(urlString)
		guard let url = URL(string: urlString) else { return }

		URLSession.shared.dataTask(with: url) { (data, response, err) in
			if let error = err {
				print("To the user" , error.localizedDescription)
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
					guard let cities = currentWeatherDecoded.cities else { return }
					completionHandler(err, cities)

				}

			} catch let jsonErr {
				print("Error serializing json:", jsonErr)

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



    



