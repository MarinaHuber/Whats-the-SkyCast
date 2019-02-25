
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import Foundation


extension UserDefaults {
    private static let citiesKey = "citiesKey"
    
    var cities: [ForcastBackground] {
        get {
            let decoder = JSONDecoder()
            if let data = value(forKey: UserDefaults.citiesKey) as? Data,
                let cities = try? decoder.decode([ForcastBackground].self, from: data) {
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
