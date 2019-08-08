//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct CurrencyConverterViewModel: CurrencyConverterViewModelProtocol
{
    private weak var currencyViewController: CurrencyConverterViewProtocol?
    private var currencyConverter: CurrencyConverterCalculator

    private var currenciesRates: [String: Double] = [:]
    
    private var waitingForFromCurrecyToSet: Bool
    
    private var currencyFrom: String?
    private var currencyTo: String?
    
    init(currencyViewController: CurrencyConverterViewProtocol)
    {
        self.currencyViewController = currencyViewController
        self.currencyConverter = CurrencyConverterCalculator()
        waitingForFromCurrecyToSet = false
        
        // TODO: remove it and uses just the currencies from the service
        createStubValues()
        
        currencyConverter.baseCurrency = "EUR"
        currencyConverter.currencies = currenciesRates
    }
    
    private mutating func createStubValues()
    {
        self.currenciesRates = [
            "AUD": 1.566015,
            "CAD": 1.560132,
            "CHF": 1.154727,
            "CNY": 7.827874,
            "GBP": 0.882047,
            "JPY": 132.360679,
            "USD": 1.23396,
        ]
    }
    
    // TODO: call service to retrieve list of exchanger rates

    mutating func selectCurrencyTopButtonPressed()
    {
        waitingForFromCurrecyToSet = true
        currencyViewController?.presentCurrencyPicker(currencies: currenciesRates.keys.sorted())
    }
    
    mutating func selectCurrencyBottomButtonPressed()
    {
        waitingForFromCurrecyToSet = false
        currencyViewController?.presentCurrencyPicker(currencies: currenciesRates.keys.sorted())
    }
    
    mutating func currencyIndexSelected(index: Int)
    {
        if waitingForFromCurrecyToSet
        {
            currencyFrom = currenciesRates.keys.sorted()[index]
        }
        else
        {
            currencyTo = currenciesRates.keys.sorted()[index]
        }
        
        let viewData = CurrencyConverterViewData(topAmount: nil,
                                                 topCurrency: currencyFrom,
                                                 bottomAmount: nil,
                                                 bottomCurrency: currencyTo)
        currencyViewController?.updateView(viewData: viewData)
    }
    
    func convertButtonPressed(importToConvert: String)
    {
        guard let number = NumbersUtil.convertStringToDouble(stringNumber: importToConvert) else {
            // TODO: show error
            
            return
        }
        
        guard let currencyFrom = currencyFrom, let currencyTo = currencyTo else {
            // TODO: show error
            
            return
        }
        
        let valueConverted = currencyConverter.convertCurrencyValue(fromCur: currencyFrom,
                                                                    toCur: currencyTo,
                                                                    valueToConvert: number)
        
        guard let stringConverted = NumbersUtil.converDoubleToFormattedString(importInserted: valueConverted) else {
            // TODO: show error in formatting
            return
        }
        
        let viewData = CurrencyConverterViewData(topAmount: importToConvert,
                                                 topCurrency: currencyFrom,
                                                 bottomAmount: stringConverted,
                                                 bottomCurrency: currencyTo)
        
        currencyViewController?.updateView(viewData: viewData)
    }
}
