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

@MainActor
class CatFacts: Endpoint, ObservableObject {

    @Published var fact: Fact?
    init() {
        super.init(baseUrl: "https://cat-fact.herokuapp.com/")
    }
    
    func getRandomFact() async throws -> Fact {
        let data = try await fetch(method: "facts/random?animal_type=cat&amount=1")
        return try JSONDecoder().decode(Fact.self, from: data)
    }

    func reload() {
        Task {
            fact = try? await getRandomFact()
        }
    }
}
