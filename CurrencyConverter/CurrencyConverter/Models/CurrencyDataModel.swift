//
//  CurrencyDataModel.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 08/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct CurrencyDataModel: Codable
{
  let rates: [String: Double]
  let baseCurrency: String
  let updateTime: Date
}
