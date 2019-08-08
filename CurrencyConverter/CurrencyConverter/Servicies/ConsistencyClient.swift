//
//  ConsistencyClient.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 08/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct ConsistencyClient
{
    private static let ratesKey: String = "ratesUserKey"
    
    static func setRates(currencyModel: CurrencyDataModel)
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currencyModel) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: ratesKey)
        }
    }
    
    static func getRates() -> CurrencyDataModel?
    {
        let defaults = UserDefaults.standard
        if let dataModel = defaults.object(forKey: ratesKey) as? Data {
            let decoder = JSONDecoder()
            guard let loadedModel = try? decoder.decode(CurrencyDataModel.self, from: dataModel) else {
                return nil
            }
            
            return loadedModel
        }
        
        return nil
    }
}
