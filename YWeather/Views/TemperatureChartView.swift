//
//YWeather
//TemperatureChartView.swift
//

import Foundation
import Charts

class TemperatureChartView: LineChartView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureChart()
    }

    fileprivate func configureChart() {
        self.dragEnabled = false
        self.scaleXEnabled = false
        self.scaleYEnabled = false
        let xAxis = self.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .white
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        
        let xValuesNumberFormatter = ChartXAxisFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/d"
        xValuesNumberFormatter.dateFormatter = dateFormatter
        xAxis.valueFormatter = xValuesNumberFormatter
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDataForChart(obj: WeatherDataModel) {
        guard let daily = obj.daily else {return}
        var data = [ChartDataEntry]()
        daily.forEach({ (daily) in
            guard let day = daily.dt, let temp = daily.temp?.day else {return}
            data.append(ChartDataEntry(x: Double(day), y: round((temp))))
        })
        xAxis.labelCount = data.count
        leftAxis.labelTextColor = .white
        let dataSet =  LineChartDataSet(entries: data)
        dataSet.valueTextColor = .white
        dataSet.label = "Day Teampereture Graphic"
        self.data = LineChartData(dataSet: dataSet)
        self.legend.textColor = .white
    }
}

extension TemperatureChartView: IObserverProtocol {
    func dataSetDidChaged(data: WeatherDataModel?) {
        guard let data = data else {return}
        self.setDataForChart(obj: data)
    }
}
