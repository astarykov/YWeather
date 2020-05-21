//
//YWeather
//WeatherDataModel.swift
//

import Foundation
import RealmSwift

struct WeatherDataModel: Codable {
    var current: Current?
    var daily: [WeatherDalyModel]?
}

struct Current: Codable {
    var dt: Int?
}

struct WeatherDalyModel: Codable {
    var dt: Int?
    var temp: Temp?
    var weather: [Weather]?
    var wind_speed: Double?
}

struct Weather: Codable {
    var description: String?
    var icon: String
}

struct Temp: Codable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn :Double?
}

extension WeatherDataModel {
    mutating func slice(_ range: Int) {
        if let count = self.daily?.count, count > range {
            self.daily?.removeSubrange(range...count-1)
        }
    }
}
