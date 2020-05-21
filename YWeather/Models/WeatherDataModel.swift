//
//YWeather
//WeatherDataModel.swift
//

import Foundation
import RealmSwift
import Unrealm

typealias RealmCodable = Realmable & Codable

struct WeatherDataModel: RealmCodable {
    var current: Current?
    var daily: [WeatherDalyModel]?
}

struct Current: RealmCodable {
    var dt: Int?
}

struct WeatherDalyModel: RealmCodable {
    var dt: Int?
    var temp: Temp?
    var weather: [WeatherIcon]?
    var wind_speed: Double?
}

struct WeatherIcon: RealmCodable {
    var icon: String?
    var main: String?
}

struct Temp: RealmCodable {
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
