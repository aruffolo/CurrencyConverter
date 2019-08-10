//
//  ConsistencyServiceMock.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 10/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
@testable import CurrencyConverter

struct ConsistencyServiceMock: ConsistencyProtocol
{
    var shouldHaveCache: Bool
    var model: CurrencyDataModel {
        let rates: [String: Double] = [
            "EUR": 1,
            "AUD": 1.566015,
            "CAD": 1.560132,
            "CHF": 1.154727,
            "CNY": 7.827874,
            "GBP": 0.882047,
            "JPY": 132.360679,
            "USD": 1.23396
        ]

        let date = Date(timeIntervalSince1970: 0)
        return CurrencyDataModel(rates: rates, baseCurrency: "EUR", updateTime: date)
    }
    
    func setRates(currencyModel: CurrencyDataModel)
    {
        // nothing to do here
    }
    
    func getRates() -> CurrencyDataModel?
    {
        if shouldHaveCache
        {
            return model
        }
        
        return nil
    }
}
