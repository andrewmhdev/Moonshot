//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Andrew H on 5/23/22.
//

import Foundation

class CoinController {
    
    //SOT
    static var coins: [Coin] = []
    
    private static let baseUrlString = "https://api.coingecko.com/api/v3"
    
    private static let keyCoinsComponent = "coins"
    
    private static let keyListComponent = "list"
    
    //MARK: CRUD
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        
        
        guard let baseUrl = URL(string: baseUrlString) else {return completion(false)}
        let coinsUrl = baseUrl.appendingPathComponent(keyCoinsComponent)
        let finalUrl = coinsUrl.appendingPathComponent(keyListComponent)
        print(finalUrl)
    }
    
}
