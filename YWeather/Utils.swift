//
//YWeather
//Utils.swift
//

import Foundation

open class Utils {
    static func convertTimeStampIntoDay(_ value: Int) -> String {
        let unixTimestamp = value
        let date = Date(timeIntervalSince1970: Double(unixTimestamp))
        let df = DateFormatter()
        df.dateFormat = "MMM d"
        return df.string(from: date)
    }
}
