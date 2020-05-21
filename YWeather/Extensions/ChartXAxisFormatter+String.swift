//
//YWeather
//ChartXAxisFormatter+String.swift
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject {
    var dateFormatter: DateFormatter?
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if let dateFormatter = dateFormatter {

            let date = Date(timeIntervalSince1970: value)
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
