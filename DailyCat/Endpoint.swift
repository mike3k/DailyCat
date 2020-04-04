//
//  Endpoint.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

class Endpoint: NSObject {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        super.init()
    }
    
    func request(url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    func fetch(method: String, completion: @escaping (Any?)->Void) {
        let urlString = "\(baseUrl)\(method)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request(url: url), completionHandler: {(data, response, error) in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                completion(json)
            } else {
                completion(nil)
            }
        })
        dataTask.resume()
    }
    
}
