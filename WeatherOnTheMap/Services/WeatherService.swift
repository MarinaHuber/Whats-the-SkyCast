//
//  WeatherService.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 12/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import UIKit

//protocol WeatherServiceDelegate {
//    func setWeather(weather: AllCurrentWeather)
//    func weatherErrorWithMessage(message: String)
//}


// TODO:check Daniel notes on generics
//enum ResultType<T> {
//    case Success(T)
//    case Failure(e: Error)
//}

enum APIRouter {

	static let APIKey: String = "c6e381d8c7ff98f0fee43775817cf6ad"
	static let base_URL = "http://api.openweathermap.org/data/2.5/"
}

class WeatherService {


  //  1. create basic request without making the object first
  //  2. getCurrenWeather is after made the object
  //  The limit of locations is 20: treated as 6 API calls for 6 city IDs
  //  &units=metric url added GET for Celsius units temp
  
    public static func getCurrentWeatherAll(_ completionHandler: @escaping (_ error: Error?, _ cities: [Cities] ) -> ()) {
        let urlString = String("\(APIRouter.base_URL)group?id=2172797,2643743,1016666,524901,703448,1851632&units=metric&appid=\(APIRouter.APIKey)")
       // print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
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
					completionHandler(err, currentWeatherDecoded.cities!)
                    
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
    
            }
            
            }.resume()
    }
    



	public static func getCityWeather(_ city: String, completion: @escaping (SingleCurrentWeather, Error?) -> ()) {
		let urlString = String("\(APIRouter.base_URL)/weather?q=" + (city.replacingOccurrences(of: " ", with: "%20")) + "&units=metric&appid=\(APIRouter.APIKey)")

		guard let url = URL(string: urlString) else { return }
		//https://oleb.net/blog/2018/03/making-illegal-states-unrepresentable/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B345
		let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
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
					completion(currentForecastDecoded, nil)
				})
			} catch let jsonErr {
				print("Error serializing json:", jsonErr)
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


//
//	 // MARK: - Helper functions for temperature conversion
//    open func cToFahrenheit(tempC: Double) -> Double {
//        return (tempC * 1.8) + 32
//    }
    

//    func kelvinToCelsius(tempK: Double) -> Double {
//        return tempK - 273.15
//    }
//
//	open func fToC(tempF: Double) -> Double {
//		return (tempF - 32) / 1.8
//	}
//
//    // it comes in celsius units
//    
//    func fixTempForDisplayFahrenheit(temp: Double) -> String {
//        print("Kelvin: \(temp)")
//        print("C: \(temp - 273.15)")
//        
//        let tempC = kelvinToCelsius(tempK: temp)
//        let tempF = cToFahrenheit(tempC: tempC)
//        let tempR = Int(round(tempF))
//        let tempString = String(format: "%.0f", tempR)
//        return tempString
//    }

    
    }



    



