//
//  ForecastWeatherController.swift
//  SimpleWeather
//

//  Created by Дмитрий Станкевич on 16.01.22.
//

import SnapKit
import UIKit

class ForecastWeatherController: UIViewController {
    //MARK: - Varibles
    private var list: [FWList] = []
    static var coordinate: [String: String]?
    
    private var numberOfCellInFirstSection: Int = 1
    private let numberOfSection: Int = 5
    private let numberOfCellAtherSection: Int = 8
    
    //MARK: - GUI Varibles
    private lazy var tableView: UITableView =  {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.reuseIdentifier)
        // Сепоратор - разделитель
        tableView.separatorStyle = .singleLine
        //Убираем разделители в пустой таблице
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        return tableView
    }()
    
    
    
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.separatorColor = .black
        self.view.addSubview(tableView)
        
        setupTableViewCinstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Swift.debugPrint(ForecastWeatherController.coordinate)
        
        Networking.shared.request(
            url: UrlPath.forecastWeather,
            parametrs: ForecastWeatherController.coordinate,
            successHendler: { [weak self] (model: ForecastWeather) in
                Swift.debugPrint("Number of all cells -- \(model.list.count)")
                self?.list = model.list
                self?.tableView.reloadData()
            },
            errorHendler: {[weak self] (error: NetworkError) in
                //self?.hundleError(error: error)
                Swift.debugPrint(error)
            })
    }
    
    //MARK: - Constraints
    private func setupTableViewCinstraints() {
        NSLayoutConstraint.activate([self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    

}


extension ForecastWeatherController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfCellInFirstSection: Int = 0
        switch section {
        case 0:
            let todayDate = self.list.first?.dtTxt
            self.list.forEach { (elemetn) in
                if elemetn.dtTxt == todayDate {
                    numberOfCellInFirstSection += 1
                }
            }
            self.numberOfCellInFirstSection = numberOfCellInFirstSection
            Swift.debugPrint("In first section -- \(numberOfCellInFirstSection)")
            return numberOfCellInFirstSection
        default:
            return self.numberOfCellAtherSection
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: WeatherCell.reuseIdentifier,
                                                      for: indexPath)
        var index: Int = 0
        
        if let cell = cell as? WeatherCell, !list.isEmpty {
            
            
            switch indexPath.section {
            case 0:
                index = indexPath.row
            default:
                index = (self.numberOfCellInFirstSection) + (indexPath.section * self.numberOfCellAtherSection) + indexPath.row - self.numberOfCellAtherSection
            }
            
            if let list: FWList? = self.list[index] {
                
                cell.setCell(time: formatFullDate(fullDate: list!.dtTxt, format: "HH-mm"),
                             weather: list!.weather.first!.main.rawValue,
                             tempr: String(Int(list!.main.temp - 273)))
                //TODO: - оформить код
                Networking.shared.requestImage(
                    name: list?.weather.first?.icon ?? "2n",
                    successHendler: {[weak self]  (dataImage) in
                        cell.setCellImage(image: dataImage)
                    },
                    errorHendler: {[weak self] (error: NetworkError) in
                        //self?.hundleError(error: error)
                    })
            }
            
        }
        Swift.debugPrint("Sec - \(indexPath.section) Row - \(indexPath.row) --- index - \(index)")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.numberOfLines = 1
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 25)
            
            return label
        }()
        
        var index = (self.numberOfCellInFirstSection) + (section * self.numberOfCellAtherSection) - self.numberOfCellAtherSection
        
        if !self.list.isEmpty {
            switch section {
            case 0:
                label.text = "Today"
            default:
                label.text = formatFullDate(fullDate: self.list[index].dtTxt, format: "EEEE")
            }
        }
        
        return label
    }
    
    //MARK: - Methods
    private func formatFullDate(fullDate: String, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: fullDate)!
        formatter.dateFormat = format
        let str = formatter.string(from: date)
        return str
    }
    
}
