//
//  Endpoint.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import Foundation

class Endpoint: NSObject {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        super.init()
    }
    
    func request(url: URL) -> URLRequest {
        return URLRequest(url: url)
    }

    func fetch(method: String) async throws -> Data {
        let urlString = "\(baseUrl)\(method)"
        let url = URL(string: urlString)!
        let (data,_) = try await URLSession.shared.data(for: request(url: url))
        return data
    }
    
}
