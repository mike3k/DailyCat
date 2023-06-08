//
//  CatFacts.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import Foundation

struct Fact: Codable {
    let text: String
    let deleted: Bool
}

class CatFacts: Endpoint, ObservableObject {

    @Published var fact: Fact?
    init() {
        super.init(baseUrl: "https://cat-fact.herokuapp.com/")
    }
    
    func getRandomFact() {
        fetch(method: "facts/random?animal_type=cat&amount=1") { (data) in
            let decoder =  JSONDecoder()
            if let data = data, let result = try? decoder.decode(Fact.self, from: data) {
                DispatchQueue.main.async { self.fact = result }
            }
        }
    }
}
