//
//  DataObjectProvider.swift
//  YWeather
//
//  Created by tonny on 5/21/20.
//  Copyright © 2020 tonny. All rights reserved.
//

import Foundation

class DataObjectProvider {
    
    static let shared = DataObjectProvider()
    
    private let localDatabaseService = LocalDatabaseService()
    private let networkRequestService = NetworkRequestService()
    
    private init() {}
    
    public func provideData(request: Request, completion: @escaping (_ obj: WeatherDataModel)->()) {
        
        DispatchQueue.global(qos: .background).async {
            if let cached = self.localDatabaseService.retrieve() {
                DispatchQueue.main.async {
                    completion(cached)
                }
            }

            self.networkRequestService.getWeatherData(request: request, completion: { (model) in
                self.localDatabaseService.save(data: model)
                DispatchQueue.main.async {
                    completion(model)
                }
            })
        }
    }
}
