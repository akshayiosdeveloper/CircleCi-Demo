//
//  Gecoder.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 08/07/22.
//

import Foundation
import CoreLocation

struct Geocoder {
    
    static func getCordinates(cityName: String) {
        var lat = 0.0 , long = 0.0
        CLGeocoder().geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                print(error)
            }
            if let latitude = placemarks?.first?.location?.coordinate.latitude ,let longitude = placemarks?.first?.location?.coordinate.longitude {
               print("lat-->\(latitude) , \(longitude)")
                lat = latitude
                long = longitude
                let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(String(describing: lat))&lon=\(String(describing: long))&exclude=current,minutely,hourly,alerts&appid=e65b8da8a136d24966fc9dea5f8560b4"
                print("-->url\(url)")
                let apiservice = ApiService.shared
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, MMM, d"
                apiservice.getJSON(urlString: url, resultType: ForeCast.self,dateDecodingStrategy: .secondsSince1970) { result in
                    switch result {
                    case.success(let data):
                        for daily in data.daily {
//                            print(daily.dt)
//                            print(dateFormatter.string(from: daily.dt))
//                            print("Max:",daily.temp.max)
//                            print("Min:",daily.temp.min)
//                            print("Humidity:",daily.humidity)
//                            print("Description:",daily.weather[0].description)
//                            print("clouds:",daily.clouds)
//                            print("icon",daily.weather[0].weatherIconURL)
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
            }
           
        }
        }
    }
}
