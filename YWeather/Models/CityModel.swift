//
//YWeather
//CityModel.swift
//

import Foundation

struct CityModel {
    var name: String
    var lat: Double
    var long: Double
    
    init(name: String, lat: Double, long: Double ) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}
