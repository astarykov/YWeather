//
//  MainViewController.swift
//  YWeather
//

import UIKit
import Charts

class MainViewController: UIViewController {
    
    fileprivate var headerView = HeaderView()
    fileprivate var lineChartView = TemperatureChartView()
    fileprivate lazy var collectionView = {
         return WeatherDaysCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    }()
    
    fileprivate var observers = [IObserverProtocol]()
    
    private var dataModel: WeatherDataModel? {
        didSet {
            observers.forEach { (observer) in
                observer.dataSetDidChaged(data: dataModel)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        
        self.observers.append(headerView)
        self.observers.append(lineChartView)
        self.observers.append(collectionView)

        setSubviews()
        
        let request = Request(city: Constants.defaultCity, apiKey: Constants.apiKey, range: .week)

        NetworkRequestService.shared.getWeatherData(request: request, completion: { (model) in
            self.dataModel = model
        })
    }
    
    fileprivate func addSubviewsWithAutolayouts() {
        [headerView, lineChartView, collectionView].forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }

    fileprivate func setSubviews() {
        self.addSubviewsWithAutolayouts()
        
        //MARK: - HeaderView constraints
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        
        //MARK: - CollectionView delegate & constraints
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true

        //MARK: - ChartView delegate & constraints
        lineChartView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        lineChartView.delegate = self
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataModel?.daily?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = self.dataModel,
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            cell.configure(with: model, at: indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension MainViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let index = self.dataModel?.daily?.firstIndex(where: { (item) -> Bool in
            Double(item.dt ?? 0) == entry.x
        }) {
            self.collectionView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension MainViewController: ISegmentControlProtocol {
    func segmentControlDidChangeValue(value: SegmentControlRange) {
        let request = Request(city: Constants.defaultCity, apiKey: Constants.apiKey, range: value)
        NetworkRequestService.shared.getWeatherData(request: request, completion: { (model) in
            self.dataModel = model
        })
    }
}
