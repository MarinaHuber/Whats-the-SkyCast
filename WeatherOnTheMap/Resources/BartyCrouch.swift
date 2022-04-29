//
//  BartyCrouch.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 28.04.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation

enum BartyCrouch {
    enum SupportedLanguage: String {
        case spanish = "es"
        case english = "en"
    }
    
    static func translate(key: String, translations: [SupportedLanguage: String], comment: String? = nil) -> String {
        let typeName = String(describing: BartyCrouch.self)
        let methodName = #function
        
        print(
            "Warning: [BartyCrouch]",
            "Untransformed \(typeName).\(methodName)",
            "method call found with key '\(key)'",
            "and base translations '\(translations)'.",
            "Please ensure that BartyCrouch is installed and configured correctly."
        )
        
            // fall back in case something goes wrong with BartyCrouch transformation
        return "BC: TRANSFORMATION FAILED!"
    }
}
