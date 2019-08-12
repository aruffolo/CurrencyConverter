//
//  ExchangeRatesResponse.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct ExchangeRates: Codable
{
  let success: Bool
  let timestamp: Int
  let base, date: String
  let rates: [String: Double]
}
