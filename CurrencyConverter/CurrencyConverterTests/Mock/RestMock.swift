//
//  ApiMock.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 10/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import Alamofire
@testable import CurrencyConverter

class RestMock: RestProtocol
{
  var failing: Bool
  var responseInvalid: Bool
  
  init(failing: Bool, responseInvalid: Bool)
  {
    self.failing = failing
    self.responseInvalid = responseInvalid
  }
  
  func latestCurrenciesRates(completion: @escaping (AFResult<ExchangeRates>) -> Void) {
    if failing
    {
      completion(Result.failure(RatesFetchError.genericError))
    }
    else if responseInvalid
    {
      let rates: [String: Double] = [:]
      let response = ExchangeRates(success: true, timestamp: 10, base: "EUR", date: "2019-08-06", rates: rates)
      completion(Result.success(response))
    }
    else
    {
      createFakeSuccessResponse(completion: completion)
    }
  }
  
  private func createFakeSuccessResponse(completion: @escaping (AFResult<ExchangeRates>) -> Void) {
    let rates: [String: Double] = [
      "EUR": 1,
      "AUD": 1.566015,
      "CAD": 1.560132,
      "CHF": 1.154727, "CNY": 7.827874, "GBP": 0.882047, "JPY": 132.360679, "USD": 1.23396]
    let response = ExchangeRates(success: true, timestamp: 10, base: "EUR", date: "2019-08-06", rates: rates)
    completion(Result.success(response))
  }
}
