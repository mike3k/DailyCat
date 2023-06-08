//
//  CatApi.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import Foundation

private let apiKey = "6438943e-2ac1-4d15-a9e5-3c47b50d7279"

struct CatImage: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

class CatApi: Endpoint, ObservableObject {
    @Published var imageInfo: CatImage?
    init() {
        super.init(baseUrl: "https://api.thecatapi.com/v1/")
    }
    
    override func request(url: URL) -> URLRequest {
        var request = super.request(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
    func getRandomImage() {
        fetch(method: "images/search?limit=1") { (data) in
            let decoder =  JSONDecoder()
            if let data = data,
                let result = try? decoder.decode([CatImage].self, from: data),
                result.count > 0 {
                DispatchQueue.main.async { self.imageInfo = result[0] }
            }
        }
    }
}
