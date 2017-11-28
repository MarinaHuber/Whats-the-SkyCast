//
//  WeatherService.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol WeatherServiceDelegate {
    func setWeather(weather: AllCurrentWeather)
    func weatherErrorWithMessage(message: String)
}
enum ResultType<T> {
    case Success(T)
    case Failure(e: Error)
}

class WeatherService {
    // Set your appid
    let appid: String
    var delegate: WeatherServiceDelegate?
    static let shared = WeatherService(appid: "")
    /** Initial a WeatherService instance with your OpenWeatherMap app id. */
    init(appid: String) {
        self.appid = appid
    }
    
// this is also data managment
    var storedFavoriteItems: Array<String>? = nil
    
    var favoriteCities: Array<String> {
        get {
            return storedFavoriteItems! //?? loadFavoriteItems()
        }
        
        set (newValue) {
            
            storedFavoriteItems = newValue
            
            DispatchQueue.main.async() {
               // self.saveFavoriteItems(newValue)
                
            }
            
            
            
        }
    }
    /** Formats an API call to the OpenWeatherMap service. Pass in a CLLocation to retrieve weather data for that location.  */
//    func getWeatherForLocation(location: CLLocation) {
//        let lat = location.coordinate.latitude
//        let lon = location.coordinate.longitude
//
//        // Put together a URL With lat and lon
//        let path = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appid)"
//
//        //getWeatherWithPath(path)
//    }
    
  //  1. create basic request without making the object first
  // 2. getCurrenWeather is after made the object
  
    public func getCurrentWeather(_ completionHandler: @escaping (_ error: Error?, _ cities: [Cities] ) -> ()) {
        let urlString = String("\(APIRouter.base_URL)group?id=524901,703448,2643743,5128581&units=metric&appid=\(APIRouter.APIKey)")
        print(urlString)
        //let urlString = String("\(Constants.base_URL)?id=2643743&units=metric&APPID=\(Constants.APIKey)")
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
                //for oneCity in currentWeatherDecoded.list {
                //    print(oneCity)
                //}
                DispatchQueue.main.async() {
                    
                    //1. create let currentWeather:CurrentWeather
                    
                    // Any of the following allows me to access the data from the JSON
//                    self.locationLabel.text = "\(json.name)"
//                    self.temperatureLabel.text = "Currently: \(json.main.temp)ºC"
//                    self.humidityLabel.text = "Humidity: \(json.main.humidity)%"
//                    self.windSpeedLabel.text = "Wind Speed: \(json.wind.speed) km/h"
                    
                    
                    
                    completionHandler(err, currentWeatherDecoded.cities)
                    
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
    
            }
            
            }.resume()
    }
    
    
//    public func getLocation(_ completionHandler: @escaping (NSError?, Array<Coord>?) -> ()) {
//        let urlString = String("\(Constants.base_URL)?APPID=\(Constants.APIKey)&q=London")
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            guard let data = data else { return }
//            do {
//                let location = try JSONDecoder().decode([AllCurrentWeather].self, from: data)
//                print(location)
//
//            } catch let jsonErr {
//                print("Error serializing json:", jsonErr)
//            }
//
//            }.resume()
//    }
    
    // this is data managment
    
    class func removeFavoriteCity (_ imageName: String) {
        shared.favoriteCities.removeLast()
    }
    
//    class func getFavoriteCities() -> Array<String> {
//
//        return shared.favoriteCities.map {
//            value in
//            return value
//        }
    
    
    
    }
    



