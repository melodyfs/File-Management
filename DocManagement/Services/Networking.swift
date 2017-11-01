//
//  Networking.swift
//  DocManagement
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

class Networking {
    
    static var shared = Networking()
    
    let urlString = "https://api.myjson.com/bins/1165qr"
    let session = URLSession.shared
    
    func getCollection(completion: @escaping (Data) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, res, err) in
            if let data = data {
                completion(data)
                print(data)
            } else {
                print(err?.localizedDescription ?? "Error")
            }

        }.resume()
        
    }
    
}
