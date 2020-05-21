//
//YWeather
//CaseIterable+Index.swift
//

import Foundation

extension Hashable where Self : CaseIterable {
    var index: Self.AllCases.Index {
        return type(of: self).allCases.firstIndex(of: self)!
    }
}
