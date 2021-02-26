//
//  NetworkManager.swift
//  World Saving Team
//
//  Created by Nikita Entin on 22.02.2021.
//

import Foundation
import UIKit

struct NetworkManager {
    
    
    var onCompletion: ((NetworkData) -> Void)?
    
    func parseData() {
        let urlString = "https://breaking-bad-quotes.herokuapp.com/v1/quotes"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let currentHero = parseJSON(withData: data) {
                    onCompletion?(currentHero)
                }
            } 
        }
        dataTask.resume()
    }
    
    func parseJSON(withData data: Data) -> NetworkData? {
        let decoder = JSONDecoder()
        do {
            let heroes = try decoder.decode([NetworkData].self, from: data)
            return heroes.randomElement()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
    
}

