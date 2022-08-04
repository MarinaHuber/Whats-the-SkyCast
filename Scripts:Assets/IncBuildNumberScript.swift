//
//  IncBuildNumber.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 25.05.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//

import Foundation

@main
enum IncBuildNumber {
    static func main() {
            // 1
        guard let infoFile = ProcessInfo.processInfo
            .environment["INFOPLIST_FILE"]
        else {
            return
        }
        guard let projectDir = ProcessInfo.processInfo.environment["SRCROOT"] else {
            return
        }
            // 2
        if var dict = NSDictionary(contentsOfFile: projectDir + "/" + infoFile) as? [String: Any] {
            guard let currentVersionString = dict["CFBundleShortVersionString"] as? String else { return }

            if ProcessInfo.processInfo.environment["CONFIGURATION"] == "Release" {
                var versionComponents = currentVersionString
                    .components(separatedBy: ".")
                let lastComponent = (Int(versionComponents.last ?? "1") ?? 1)
                versionComponents[versionComponents.endIndex - 1] =
                "\(lastComponent + 1)"
                dict["CFBundleShortVersionString"] = versionComponents
                    .joined(separator: ".")
            }
                // 5
            (dict as NSDictionary).write(
                toFile: projectDir + "/" + infoFile,
                atomically: true)
        }
    }
}

