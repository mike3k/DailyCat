//
//  CatFacts.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

class CatFacts: Endpoint {
    init() {
        super.init(baseUrl: "https://cat-fact.herokuapp.com/")
    }
    
    func getRandomFact(completion: @escaping ([AnyHashable: Any]?)->Void) {
        fetch(method: "facts/random?animal_type=cat&amount=1") { (json) in
            let fact = json as? [AnyHashable: Any]
            completion(fact)
        }
    }
}
