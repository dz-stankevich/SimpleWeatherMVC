// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ForecastWeather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [FWList]
    let city: FWCity
}

// MARK: - City
struct FWCity: Codable {
    let id: Int
    let name: String
    let coord: FWCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct FWCoord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct FWList: Codable {
    let dt: Int
    let main: FWMainClass
    let weather: [FWWeather]
    let clouds: FWClouds
    let wind: FWWind
    let visibility: Int
    let pop: Double
    let sys: FWSys
    let dtTxt: String
    let rain: FWRain?
    let snow: FWSnow?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
        case snow
    }
}

// MARK: - Clouds
struct FWClouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct FWMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct FWRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct FWSnow: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct FWSys: Codable {
    let pod: FWPod
}

enum FWPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct FWWeather: Codable {
    let id: Int
    let main: FWMainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum FWMainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct FWWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
