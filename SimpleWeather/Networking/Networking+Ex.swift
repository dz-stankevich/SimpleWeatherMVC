//
//  Networking+Ex.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 19.01.22.
//

import Foundation
import UIKit

extension Networking {
    func gerUrlWith(url: String,
                    path: String,
                    parameters: [String: String]? = nil) -> URL? {
        guard var components = URLComponents(string: url + path) else { return nil}
        if let parameters = parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        }
        
        return components.url
    }
}

    
    

