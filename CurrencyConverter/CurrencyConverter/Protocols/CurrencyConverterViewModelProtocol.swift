//
//  CurrencyConverterViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewModelProtocol
{
    mutating func viewWillAppear()
    
    mutating func selectCurrencyTopButtonPressed()
    mutating func selectCurrencyBottomButtonPressed()
    
    mutating func convertButtonPressed(importToConvert: String)
    
    mutating func currencyIndexSelected(index: Int)
    mutating func topAmountChanged(amount: String)
}
