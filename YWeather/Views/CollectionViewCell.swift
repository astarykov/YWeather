//YWeather
//CollectionViewCell.swift

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    fileprivate var temperature = UILabel()
    fileprivate var date = UILabel()
    fileprivate var icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCellLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setCellLayout() {
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderColor = UIColor(red: 0.7, green: 0.3, blue:0.1, alpha: 1.0).cgColor
        self.contentView.layer.borderWidth = 1.0
        contentView.addSubview(temperature)
        contentView.addSubview(date)
        contentView.addSubview(icon)

        temperature.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        temperature.font = UIFont(name: "System", size: 20)
        temperature.textColor = .white
        
        date.font = UIFont(name: "System", size: 20)
        date.textColor = .white
        date.textAlignment = .center
        
        temperature.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        temperature.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        date.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        date.bottomAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        
        icon.topAnchor.constraint(equalTo: temperature.bottomAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
    }
    
    func configure(with data: WeatherDataModel, at index: Int) {
        if let daily = data.daily?[index], let temp = daily.temp?.day, let iconId = daily.weather?.first?.icon, let day = daily.dt {
            temperature.text = "\(round(temp)) °C"
            date.text = Utils.convertTimeStampIntoDay(day)
            let iconId = iconId
            icon.load(url: URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")!)
        } else {
            print("Unable to parse one of data fields")
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        temperature.text = ""
        date.text = ""
        icon.image = nil
    }
}
