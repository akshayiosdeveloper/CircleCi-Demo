//
//  ForeCastViewModel.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 11/07/22.
//

import Foundation
struct ForeCastViewModel {
    
    let forecast:ForeCast.Daily
    var system:Int
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert(temp:Double) -> Double {
        let celcesius = temp - 273.5
        if system == 0 {
            return celcesius
        } else {
            let kalvin = celcesius * 9 / 5 + 32
            return kalvin
        }
    }
    
    var day: String {
        Self.dateFormatter.string(from:forecast.dt)
    }
    var overView: String {
        forecast.weather[0].description.capitalized
    }
    var high: String {
        return "H: \(String(describing: Self.numberFormatter.string(for: convert(temp: forecast.temp.max))!))°"
    }
    var low: String {
        return "L: \(String(describing: Self.numberFormatter.string(for: convert(temp: forecast.temp.min))!))°"
    }
    var pop: String {
        return "💧\(String(describing: Self.numberFormatter2.string(for:forecast.pop)!))"
    }
    var clouds: String {
        return "🌩\(forecast.clouds)"
    }
    var humidity: String {
        return "\(forecast.humidity)"
    }
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
    
    var weatherIconString: String {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return urlString
    }
}
