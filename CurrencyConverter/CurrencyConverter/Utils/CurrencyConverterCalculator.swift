//
//  CurrencyConverterCalculator.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 08/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct CurrencyConverterCalculator
{
  var currencies: [String: Double]!
  
  func convertCurrencyValue(fromCur: String, toCur: String, valueToConvert: Double) -> Double
  {
    guard let baseFromRate = currencies[fromCur], let baseToRate = currencies[toCur]
      else
    {
      let errorMessage = """
      Rates provided are from the same source that creates me, I must contain them
      from currency: \(fromCur), to currency: \(toCur)
      """
      fatalError(errorMessage)
    }
    
    let baseCurValue = valueToConvert * baseFromRate
    let toCurValue = baseCurValue * baseToRate
    
    return toCurValue
  }
}
