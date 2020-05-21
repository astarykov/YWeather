//
//YWeather
//SegmentControlRange.swift
//

import Foundation

enum SegmentControlRange: String, CaseIterable {
    case threeDays = "3 Days"
    case fiveDays = "5 Days"
    case week = "Week"
    case max = "Maximum"
}

extension SegmentControlRange {
    var ordinal: Int {
        switch self {
        case .week: return 7
        case .threeDays: return 3
        case .fiveDays: return 5
        case .max: return Int.max
        }
    }
}
