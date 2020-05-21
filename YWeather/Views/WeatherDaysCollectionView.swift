//
//YWeather
//WeatherDaysCollectionView.swift
//

import Foundation
import UIKit

class WeatherDaysCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)

        self.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension WeatherDaysCollectionView: IObserverProtocol {
    func dataSetDidChaged(data: WeatherDataModel?) {
        self.reloadData()
    }
}
