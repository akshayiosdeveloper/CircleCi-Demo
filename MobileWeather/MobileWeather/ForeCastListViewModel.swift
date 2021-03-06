//
//  ForeCastListViewModel.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 12/07/22.
//

import Foundation
import CoreLocation
import SwiftUI
class ForeCastListViewModel:ObservableObject {
    struct AppError:Identifiable {
        let id = UUID().uuidString
        let errorString:String
    }
    var appError:AppError?
    @Published var forecasts:[ForeCastViewModel] = []
    @Published var isLoading:Bool = false
    @AppStorage("location") var location: String = ""
    @AppStorage("system") var system:Int = 0 {
        didSet {
            for i in  0 ..< forecasts.count {
            forecasts[i].system = system
            }
        }
    }
    init() {
        if location != "" {
            getWeatherForecast()
        }
    }
    
    func getWeatherForecast() {
        self.isLoading = true
        var lat = 0.0 , long = 0.0
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                self.isLoading = false
                self.appError = AppError(errorString: error.localizedDescription)
            }
            if let latitude = placemarks?.first?.location?.coordinate.latitude ,let longitude = placemarks?.first?.location?.coordinate.longitude {
                print("lat-->\(latitude) , \(longitude)")
                lat = latitude
                long = longitude
                let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(String(describing: lat))&lon=\(String(describing: long))&exclude=current,minutely,hourly,alerts&appid=e65b8da8a136d24966fc9dea5f8560b4"
                print("-->url\(url)")
                let apiservice = APIService.shared
                
                apiservice.getJSON(urlString: url, resultType: ForeCast.self,dateDecodingStrategy: .secondsSince1970) { result in
                    switch result {
                    case.success(let forecasts):
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.forecasts = forecasts.daily.map{ model in
                                ForeCastViewModel(forecast: model, system: self.system)
                                //ForeCastViewModel(forecast:$0)
                                
                            }
                        }
                        
                        print(self.forecasts)
                        
                        break
                    case .failure(let error):
                        print(error)
                        self.isLoading = false
                        self.appError = AppError(errorString: error.localizedDescription)
                        break
                    }
                }
                
            }
        }
        
        
    }
}
