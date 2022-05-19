//
//  BartyCrouch.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 18.05.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation

enum BartyCrouch {
    enum SupportedLanguage: String {
        case english = "en"
        case croatian = "hr"
    }
    
    static func translate(key: String, translations: [SupportedLanguage: String], comment: String? = nil) -> String {
        let typeName = String(describing: BartyCrouch.self)
        let methodName = #function
        
        print(
            "Warning: [BartyCrouch]",
            "Untransformed \(typeName).\(methodName) method call found with key '\(key)' and base translations '\(translations)'.",
            "Please ensure that BartyCrouch is installed and configured correctly."
        )
        return "BC: TRANSFORMATION FAILED!"
    }
}
