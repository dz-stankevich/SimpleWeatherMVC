//
//  MainWeatherController.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 16.01.22.
//

import UIKit
import SnapKit
import CoreLocation

class MainWeatherController: UIViewController, CLLocationManagerDelegate {
    //MARK: - Varibles
    private let separatorSize = CGSize(width: 220, height: 1)
    
    //MARK: - Location
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    //MARK: - GUI Varibles
    private lazy var mainInfo: MainWeatherInfo = {
        let info = MainWeatherInfo()
        
        return info
    }()
    
    private lazy var separatorTop: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var separatorBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    
    private lazy var detailInfo = DetailedWeather()
    
    
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(self.mainInfo)
        self.view.addSubview(self.separatorTop)
        self.view.addSubview(self.detailInfo)
        self.view.addSubview(self.separatorBottom)
        
        constraints()
        locManager.delegate = self
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()

    }
    
    //MARK: - Constraints
    private func constraints() {
        self.mainInfo.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.left.right.equalToSuperview()
        }
        
        self.separatorTop.snp.updateConstraints { (make) in
            make.top.equalTo(self.mainInfo.snp.bottom).offset(30)
            make.size.equalTo(self.separatorSize)
            make.centerX.equalToSuperview()
        }
        
        self.detailInfo.snp.updateConstraints { (make) in
            make.top.equalTo(self.separatorTop.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(16)
        }
        
        self.separatorBottom.snp.updateConstraints { (make) in
            make.top.equalTo(self.detailInfo.snp.bottom).offset(50)
            make.size.equalTo(self.separatorSize)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    private func sendWeatherRequest(lat: Double, lon: Double) {
        Swift.debugPrint("Sending request")
         
        Networking.shared.request(
            url: UrlPath.currentWeather,
            parametrs: ["lat": String(lat), "lon": String(lon)],
            successHendler: { [weak self] (model: CurrentWeather) in
                Swift.debugPrint("+++")
                self?.mainInfo.setContent(model: model)
                self?.detailInfo.setDetailWeather(model: model)
                self?.sendImageRequest(for: model.weather.first!.icon)
            },
            errorHendler: {[weak self] (error: NetworkError) in
                self?.hundleError(error: error)
            })
    }
    //https://openweathermap.org/img/wn/10d@2x.png
    //https://api.openweathermap.org/img/wn/04d@2x.png
    private func sendImageRequest(for image: String) {
        Networking.shared.requestImage(
            name: image,
            successHendler: {[weak self]  (dataImage) in
                self?.mainInfo.setImage(image: dataImage)
            },
            errorHendler: {[weak self] (error: NetworkError) in
                self?.hundleError(error: error)
            })
        
    }
    
    //MARK: - Headlers
    private func hundleError(error: NetworkError) {
        var title: String =  "Error"
        var message: String = "Somthing went wrong"
        Swift.debugPrint(error)
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Location methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            sendWeatherRequest(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            
            ForecastWeatherController.coordinate = ["lat": String(location.coordinate.latitude), "lon": String(location.coordinate.longitude)]
           }
    }

}


