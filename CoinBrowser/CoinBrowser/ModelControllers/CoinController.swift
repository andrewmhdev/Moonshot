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
        URLSession.shared.dataTask(with: finalUrl) { coinData, _, error in
            
            if let error = error {
                print("There was an \(error.localizedDescription)")
                    completion(false)
            }
            guard let data = coinData else {completion(false); return}
            
            do{
                if let topLevelArrayOfCoinDictionaries = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String:String]] {
                    
                    for coinDictionary in topLevelArrayOfCoinDictionaries {
                        if let id = coinDictionary["id"],
                           let symbol = coinDictionary["symbol"],
                           let name = coinDictionary["name"] {
                            let parsedCoin = Coin(id: id, symbol: symbol, name: name)
                            coins.append(parsedCoin)
                        }
                    }
                }
                completion(true)
            } catch {
                print("error in do/try/catch\(error.localizedDescription)")
                completion(false)
            }

            
        } .resume()
    }
    
}
