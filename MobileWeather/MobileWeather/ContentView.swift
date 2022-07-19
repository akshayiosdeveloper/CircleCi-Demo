//
//  ContentView.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 06/07/22.
//
import SwiftUI
struct ContentView: View {
    
    @StateObject private var forecastListVM = ForeCastListViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Picker(selection: $forecastListVM.system, label: Text("System")) {
                        Text("C").tag(0)
                        Text("F").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width:100)
                    .padding(.vertical)
                    HStack() {
                        TextField("Enter Location", text: $forecastListVM.location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            forecastListVM.getWeatherForecast()
                        }label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                        }
                    } // End of Hstack
                    .padding()
                    
                    List(forecastListVM.forecasts,id:\.day) {daily in
                        VStack(alignment:.leading) {
                            Text(daily.day)
                                .fontWeight(.bold)
                            HStack(alignment:.top) {
                                // UrlImageView(urlString:daily.weatherIconString)
                                
                                Image(systemName: "hourglass")
                                    .frame(width: 50, height: 50)
                                    .font(.title)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                                VStack(alignment:.leading) {
                                    Text(daily.overView)
                                    HStack {
                                        Text(daily.high)
                                        Text(daily.low)
                                    }
                                    HStack {
                                        Text(daily.clouds)
                                        Text(daily.pop)
                                    }
                                    Text(daily.humidity)
                                }
                            }
                        }
                        
                    }
                    .listStyle(PlainListStyle())
                    
                    
                    
                    
                } //end of vstack
                .padding(.horizontal)
                .navigationTitle("Weather App")
                .alert(item: $forecastListVM.appError) { alert in
                    Alert(title:Text("Error"),
                          message: Text("""
      \(alert.errorString)
  Please try again later
"""))
                    
                }
            } // navigation view
            if forecastListVM.isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                }
            }
            
        } // zstack
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
