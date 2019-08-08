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
    func viewWillAppear()
    func loadData()
    
    func selectCurrencyTopButtonPressed()
    func selectCurrencyBottomButtonPressed()
    
    func convertButtonPressed(importToConvert: String)
    
    func currencyIndexSelected(index: Int)
    func topAmountChanged(amount: String)
}
