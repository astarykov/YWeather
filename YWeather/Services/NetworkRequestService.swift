//
//YWeather
//NetworkRequestService.swift
//

import Foundation
import Alamofire

struct Request {
    var apiKey: String
    var city: CityModel
    var requiredRange: SegmentControlRange
    
    init(city: CityModel, apiKey: String, range: SegmentControlRange) {
        self.city = city
        self.apiKey = apiKey
        self.requiredRange = range
    }

    func getUrl() -> String {
        return "https://api.openweathermap.org/data/2.5/onecall?lat=\(city.lat)&lon=\(city.long)&exclude=hourly&appid=\(apiKey)&units=metric"
    }
}


class NetworkRequestService {
    static let shared = NetworkRequestService()
    private init() {}

    public func getWeatherData(request: Request, completion: @escaping (_ obj: WeatherDataModel)->()) {
        let requestAF = AF.request(request.getUrl())
            requestAF.validate().responseDecodable(of: WeatherDataModel.self) { response in
                if let result = response.value {
                    var mutableResult = result
                    mutableResult.slice(request.requiredRange.ordinal)
                    completion(mutableResult)
                }
                if let err = response.error {
                    print("\(err.localizedDescription)")
                }
            }
    }
}
