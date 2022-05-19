//
//  String+Localized.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 19.05.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
