//
//  Errors.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 19.01.22.
//

import Foundation

enum NetworkError {
    case incorrectUrl
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)
    case unknown
}
