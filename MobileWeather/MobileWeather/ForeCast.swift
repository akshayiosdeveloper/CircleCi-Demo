//
//  ForeCast.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 06/07/22.
//

import Foundation

struct ForeCast: Codable {
    struct Daily:Codable {
        let dt: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
        let humidity:Int
        struct Weather: Codable {
            let main: String
            let description: String
            let icon: String
           
        }
        let weather: [Weather]
        let clouds: Int
        let pop: Double
    }
    let daily:[Daily]
}
