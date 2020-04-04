//
//  CatApi.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

private let apiKey = "6438943e-2ac1-4d15-a9e5-3c47b50d7279"

class CatApi: Endpoint {
    init() {
        super.init(baseUrl: "https://api.thecatapi.com/v1/")
    }
    
    override func request(url: URL) -> URLRequest {
        var request = super.request(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
    func getRandomImage(completion: @escaping ([AnyHashable: Any]?)->Void) {
        fetch(method: "images/search?limit=1") { (json) in
            guard let cats = json as? [[AnyHashable: Any]],
                cats.count > 0 else {
                    completion(nil)
                    return
            }
            completion(cats[0])
        }
    }
}
