//
//  Networking.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 19.01.22.
//

import Foundation
import UIKit

class Networking {
    //MARK: - Static
    static let shared = Networking()
    
    //MARK: - Varibles
    private let baseUrl: String = "https://api.openweathermap.org/"
    private let imageUrl: String = "https://openweathermap.org/"
    private let apiKey: String = "4748c5a2e0036826711473355ec61e2f"
    
    private let imageFormat: String = "@2x.png"
    
    private lazy var session = URLSession(configuration: .default)
    
    private lazy var parameters: [String: String] = [
        "appid": self.apiKey
    ]
    
    //MARK: - Init
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        
        //TODO: - Add your properties
    }
    
    //MARK: - Methods
    func request<Generic: Decodable>(url: String,
                                     parametrs: [String: String]? = nil,
                                     successHendler: @escaping (Generic) -> Void,
                                     errorHendler: @escaping (NetworkError) -> Void) {
        
        var urlParametres = self.parameters
        if let parametrs = parametrs {
            parametrs.forEach { urlParametres[$0.key] = $0.value }
        }
        
        Swift.debugPrint(urlParametres)
        
        guard var fulUrl = self.gerUrlWith(url: baseUrl,
                                           path: url,
                                           parameters: urlParametres) else {
            errorHendler(.incorrectUrl)
            return
        }
        
        Swift.debugPrint(fulUrl)
        
        let request =  URLRequest(url: fulUrl)
        
        let dataTask = self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                //Network error heandling
                DispatchQueue.main.async {
                    errorHendler(.networkError(error: error))
                }
                return
            } else if let data: Data = data,
                      let response: HTTPURLResponse = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    //Success server response
                    do {
                        let model = try JSONDecoder().decode(Generic.self, from: data)
                        DispatchQueue.main.async {
                            successHendler(model)
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            errorHendler(.parsingError(error: error))
                        }
                    }
                    break
                case 400..<500:
                    //TODO: - Response model error heandling
                    break
                case 500...:
                    //Hendler server error
                    DispatchQueue.main.async {
                        errorHendler(.serverError(statusCode: response.statusCode))
                    }
                    break
                default:
                    //Hendler unknown error
                    DispatchQueue.main.async {
                        errorHendler(.unknown)
                    }
                }
            }
            
            
        }
        dataTask.resume()
    }
    
    func requestImage(name: String,
                      successHendler: @escaping (UIImage) -> Void,
                      errorHendler: @escaping (NetworkError) -> Void) {
        guard let fulUrl = URL(string: imageUrl + UrlPath.image + name + imageFormat)  else {
            errorHendler(.incorrectUrl)
            return
        }
        Swift.debugPrint(fulUrl)
        let request =  URLRequest(url: fulUrl)
        
        let dataTask = self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                //Network error heandling
                DispatchQueue.main.async {
                    errorHendler(.networkError(error: error))
                }
                return
            } else if let data: Data = data,
                      let response: HTTPURLResponse = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    //Success server response
                    do {
                        DispatchQueue.main.async {
                            successHendler(UIImage(data: data)!)
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            errorHendler(.parsingError(error: error))
                        }
                    }
                    break
                case 400..<500:
                    //TODO: - Response model error heandling
                    break
                case 500...:
                    //Hendler server error
                    DispatchQueue.main.async {
                        errorHendler(.serverError(statusCode: response.statusCode))
                    }
                    break
                default:
                    //Hendler unknown error
                    DispatchQueue.main.async {
                        errorHendler(.unknown)
                    }
                }
            }
            
            
        }
        dataTask.resume()
        
    }
}
