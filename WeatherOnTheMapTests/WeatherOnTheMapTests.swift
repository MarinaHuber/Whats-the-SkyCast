//
//  WeatherOnTheMapTests.swift
//  WeatherOnTheMapTests
//
//  Created by Marina Huber on 7/11/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import XCTest
@testable import WeatherOnTheMap

class WeatherOnTheMapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	//class UserTests: XCTestCase {
		func testJSONMapping() throws {
			let surl = "http://api.openweathermap.org/data/2.5/weather?q=pula&units=metric&appid=c6e381d8c7ff98f0fee43775817cf6ad"

			guard let url = URL(string: surl) else {
				XCTFail("Invalid url")
				return
			}

			guard let data = try? Data(contentsOf: url) else {
				XCTFail("Can not download")
				return
			}


			let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601

			do {
                let _ = try decoder.decode(City.self, from: data)
			} catch {
				XCTFail("Failed decoding")
			}

			do {
				let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
			
				["weather","main", "name"].forEach { key in
					guard let value = json?[key] else {
						XCTFail("no clouds key \(key)")
						return
					}

					if key == "weather" {

						if let weatherSingle = value as? [[String:Any]] {
							weatherSingle.forEach { weather in

								["id","main", "description", "icon"].forEach { wkey in
									guard let _ = weather[wkey] else {
										XCTFail("no weather single key \(wkey)")
										return
									}

								}
							}
						} else {
							XCTFail("weatherSingle issue")
						}
					}

				}
/*
				guard let _ = json?["clouds"] else {
					XCTFail("no clouds key")
					return
				}
				guard let _ = json?["dummykey"] else {
					XCTFail("dummy")
					return
				}
*/
			} catch {
				XCTFail("Failed serializing JSON")
			}
		}

}
