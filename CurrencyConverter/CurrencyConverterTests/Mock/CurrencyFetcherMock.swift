//
//  CurrencyFetcherMock.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 09/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
@testable import CurrencyConverter

struct CurrencyFetcherMock: CurrencyFetcherProtocol
{
  func latestCurrenciesRates(completion: @escaping (Result<CurrencyDataModel, RatesFetchError>) -> Void) {
    
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
    
    let dataModel: CurrencyDataModel = CurrencyDataModel(rates: rates, baseCurrency: "EUR", updateTime: Date())
    return completion(Result.success(dataModel))
  }
}

struct CurrencyFetcherFailMock: CurrencyFetcherProtocol
{
  func latestCurrenciesRates(completion: @escaping (Result<CurrencyDataModel, RatesFetchError>) -> Void) {
    let error = RatesFetchError.genericError
    return completion(Result.failure(error))
  }
}
