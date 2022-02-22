//
//  DetailedWeather.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 17.01.22.
//

import UIKit
import SnapKit

class DetailedWeather: UIView {
    //MARK: - Vribles
    private let edgeInsets = UIEdgeInsets(all: 100)
    
    //MARK: - GUI Varibles
    private lazy var humidity: DWComponent = {
        let component = DWComponent()
        component.setImage(with: "humidity-50")
        
        return component
    }()
    
    private lazy var precipitation: DWComponent = {
        let component = DWComponent()
        component.setImage(with: "precipitation-50")
        
        return component
    }()
    
    private lazy var pressure: DWComponent = {
        let component = DWComponent()
        component.setImage(with: "pressure-50")
        
        return component
    }()
    
    private lazy var windspeed: DWComponent = {
        let component = DWComponent()
        component.setImage(with: "wind-50")
        
        return component
    }()
    
    private lazy var windDirection: DWComponent = {
        let component = DWComponent()
        component.setImage(with: "direction-50")
        
        return component
    }()
    

    private lazy var mainContainer = UIView()
    
    private lazy var topContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
       stack.spacing = 60
        
        return stack
    }()
    
    private lazy var bottomContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 60

        return stack
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initView() {
        self.addSubview(self.mainContainer)
        self.mainContainer.addSubview(self.topContainer)
        self.mainContainer.addSubview(self.bottomContainer)
        
        self.topContainer.addArrangedSubviews([self.humidity, self.precipitation, self.pressure])
        self.bottomContainer.addArrangedSubviews([windspeed, windDirection])
        
        
        constraints()
    }
    
    //MARK: - Constraints
    private func constraints() {
        self.mainContainer.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.topContainer.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.bottomContainer.snp.updateConstraints { (make) in
            make.top.equalTo(self.topContainer.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    func setDetailWeather(model: CurrentWeather) {
        self.humidity.setInfo(with: String(model.main.humidity) + "%")
        self.precipitation.setInfo(with: String(model.snow?.the1H ?? 0) + "mm")
        self.pressure.setInfo(with: String(model.main.pressure) + "hPa")
        self.windspeed.setInfo(with: String(model.wind.speed) + "km/h")
        self.windDirection.setInfo(with: self.selectDirection(degrees: model.wind.deg))
        
    }
    
    private func selectDirection(degrees: Int) -> String {
        switch degrees {
        case 0...44, 236...360:
            return "N"
        case 21...65:
            return "NE"
        case 66...110:
            return "E"
        case 111...155:
            return "SE"
        case 156...200:
            return "S"
        case 201...245:
            return "SW"
        case 246...290:
            return "W"
        case 291...235:
            return "NW"
        default:
            "Error"
        }
    }
    
}
