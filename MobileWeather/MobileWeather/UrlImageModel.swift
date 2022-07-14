//
//  UrlImageModel.swift
//  MobileWeather
//
//  Created by Akshay Kumar on 13/07/22.
//

import Foundation
import UIKit
class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    //
    var imageCache = ImageCache.getImageCache()
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        loadImageFromUrl()
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.image = loadedImage
        }
    }
    
        func loadImageFromCache() -> Bool {
            guard let urlString = urlString else {
                return false
            }
            
            guard let cacheImage = imageCache.get(forKey: urlString) else {
                return false
            }
            
            image = cacheImage
            return true
        }
      
}
