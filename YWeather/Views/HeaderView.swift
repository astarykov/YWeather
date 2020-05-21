//YWeather

import Foundation
import UIKit


class HeaderView: UIView {
    
    private let cityLabel = UILabel()
    private var segmentControl = UISegmentedControl()
    
    var delegate: ISegmentControlProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init() {
        super.init(frame: .zero)
        setupLabel()
        setupControl()
    }
    
    private func setCity(city: CityModel) {
        self.cityLabel.text = city.name
    }
    
    fileprivate func setupLabel() {
        cityLabel.font = UIFont(name: "System", size: 26)
        cityLabel.textColor = .white
        cityLabel.textAlignment = .center
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(cityLabel)
        
        cityLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cityLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    fileprivate func setupControl() {
        let items = SegmentControlRange.allCases.map { (ctrl) in
            ctrl.rawValue
        }
        segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = SegmentControlRange.allCases.count-1
        segmentControl.backgroundColor = .lightGray

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.addTarget(self, action: #selector(self.segmentedControlIndexChanged(_:)), for: .valueChanged)
        
        self.addSubview(segmentControl)
        
        segmentControl.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc func segmentedControlIndexChanged(_ sender: UISegmentedControl) {
        if let range = SegmentControlRange.allCases.filter({ (value) -> Bool in
            value.index == sender.selectedSegmentIndex
        }).first {
            delegate?.segmentControlDidChangeValue(value: range)
        }
    }
    
}

extension HeaderView: IObserverProtocol {
    func dataSetDidChaged(data: WeatherDataModel?) {
        guard let data = data else {return}
        let currentDay = Utils.convertTimeStampIntoDay(data.current?.dt ?? 0)
        self.setCity(city: Constants.defaultCity)
        self.cityLabel.text?.append(" - \(currentDay)")
    }
}
