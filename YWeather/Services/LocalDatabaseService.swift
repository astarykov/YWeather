//
//  LocalDatabaseService.swift
//  YWeather
//

import Foundation
import RealmSwift
import Unrealm

class LocalDatabaseService {

    init() {
        Realm.registerRealmables(WeatherDataModel.self)
        Realm.registerRealmables(Current.self)
        Realm.registerRealmables(WeatherDalyModel.self)
        Realm.registerRealmables(WeatherIcon.self)
        Realm.registerRealmables(Temp.self)
    }
    
    public func save(data: WeatherDataModel) {
        do {
            let realm = try Realm()
            if !realm.objects(WeatherDataModel.self).isEmpty {
                try realm.write {
                    realm.deleteAll()
                }
            }
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func retrieve() -> WeatherDataModel? {
        do {
            let realm = try Realm()
            return realm.objects(WeatherDataModel.self).last
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
