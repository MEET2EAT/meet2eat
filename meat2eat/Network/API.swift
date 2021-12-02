//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    
    
    static func getMorerestaurants( numberOfRestaurants: Int!, completion: @escaping ([Restaurant]?) -> Void){
        let apikey = "PZQrOE4SLDFToPuNaquxUdML3_U_7Mcz2V2N9xl377XzGeCHaE2dIKWgY4nixaYGnSWMjHjYGoeE9d9G9JLUrRQdXOQChvhMB4HyQompGdt5toD3IuVKm0rV7oiaYXYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                
  //              let restaurants = restDictionaries.map({ Restaurant.init(dict: $0) })
               
                 //Using For Loop
               var restaurants: [Restaurant] = []
                for dictionary in restDictionaries {
                    let restaurant = Restaurant.init(dict: dictionary)
                    restaurants.append(restaurant)
                }
                
                print("Number of restaurant = \(restaurants.startIndex)");
                                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        
    }
    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "PZQrOE4SLDFToPuNaquxUdML3_U_7Mcz2V2N9xl377XzGeCHaE2dIKWgY4nixaYGnSWMjHjYGoeE9d9G9JLUrRQdXOQChvhMB4HyQompGdt5toD3IuVKm0rV7oiaYXYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                
  //              let restaurants = restDictionaries.map({ Restaurant.init(dict: $0) })
               
                 //Using For Loop
               var restaurants: [Restaurant] = []
                for dictionary in restDictionaries {
                    let restaurant = Restaurant.init(dict: dictionary)
                    restaurants.append(restaurant)
                }
                
                print("Number of restaurant = \(restaurants.startIndex)");
                                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    
    

    
}

    
