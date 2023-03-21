//
//  Model.swift
//  weather app
//
//  Created by Алексей Волобуев on 13.03.2023.
//

import Foundation
import UIKit

struct Response: Codable {
    var info: Info
    var fact: Fact
}

struct Info: Codable {
    var defPressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        case defPressureMm = "def_pressure_mm"
    }
}

struct Fact: Codable {
    var temp: Int
    var feelsLike: Int
    var icon: String
    var condition: String
    var precType: Int
    var windSpeed: Double
    var windDir: String
    var pressureMm: Int
    
    enum CodingKeya: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon
        case condition
        case precType = "prec_type"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
    }
}

struct FirstViewModel {
    var name: String
    var temp: Int
    var condition: String
    var icon: UIImage
}

struct SecondViewModel {
    var name: String
    var defPressureMm: Int
    var pressureMm: Int
    var temp: Int
    var feelsLike: Int
    var icon: UIImage
    var condition: String
    var windSpeed: Double
    var windDir: String
    var precType: Int
//    var precTypeString: String {
//        switch precType{
//        case 0 : return "No precipitation"
//        case 1 : return "Rain"
//        case 2 : return "Rain and snow"
//        case 3 : return "Snow"
//        case 4 : return "Hail"
//        default: return "No data about precipitation"
//        }
//    }
}
