
// #!/usr/bin/swift
import Foundation

let stringsFilePath: String = "WeatherOnTheMap/Supporting files/en.lproj/Localizable.strings"

let contentOfFile = try! String(contentsOfFile: stringsFilePath)

let lines = contentOfFile.split(separator: "\n").map { String($0) }

var outputStringStart = """
import Foundation

enum Localizations {

"""

var staticLetArray: [String] = []

for line in lines {
    if let index = (line.range(of: " =")?.lowerBound) {
        let key = String(line.prefix(upTo: index)).replacingOccurrences(of: "\"", with: "")
        let camaleCaseKey = key.split(separator: ".").enumerated().map { (index, element) in
            return index > 0 ? String(element).capitalized : String(element)
        }.joined()
        let finalLine = "  static let \(camaleCaseKey) = \"\(key)\".localized"
        staticLetArray.append(finalLine) //"key"
    }
}

let outputStringEnd = "\n}"
let finalOutput = outputStringStart + String(staticLetArray.joined(separator: "\n")) + outputStringEnd

try! finalOutput.write(toFile: "WeatherOnTheMap/Supporting files/Localizations.swift", atomically: true, encoding: .utf8)

//print(CommandLine.arguments.last)
print(finalOutput)
// create arguments for path to Localizable.swift
// create swift script into bash script to run on build
