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
    
    var viewData: CurrencyConverterViewData
    
    init(currencyViewController: CurrencyConverterViewProtocol)
    {
        self.currencyViewController = currencyViewController
        self.currencyConverter = CurrencyConverterCalculator()
        waitingForFromCurrecyToSet = false
        
        viewData = CurrencyConverterViewData(topAmount: "", topCurrency: "currency", bottomAmount: "", bottomCurrency: "currency")
        
        // TODO: remove it and uses just the currencies from the service
        createStubValues()
        
        currencyConverter.baseCurrency = "EUR"
        currencyConverter.currencies = currenciesRates
    }
    
    private mutating func createStubValues()
    {
        self.currenciesRates = [
            "EUR": 1,
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
    mutating func viewWillAppear()
    {
        currencyViewController?.updateView(viewData: viewData)
    }
    
    mutating func topAmountChanged(amount: String)
    {
        viewData.topAmount = amount
        currencyViewController?.updateView(viewData: viewData)
    }

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
        let selected = currenciesRates.keys.sorted()[index]
        
        if waitingForFromCurrecyToSet
        {
            currencyFrom = selected
            viewData.topCurrency = selected
        }
        else
        {
            currencyTo = selected
            viewData.bottomCurrency = selected
        }
        
        // I may want to reset the amount on the bottom
        viewData.bottomAmount = ""
        currencyViewController?.updateView(viewData: viewData)
    }
    
    mutating func convertButtonPressed(importToConvert: String)
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
        
        viewData = CurrencyConverterViewData(topAmount: importToConvert,
                                                 topCurrency: currencyFrom,
                                                 bottomAmount: stringConverted,
                                                 bottomCurrency: currencyTo)
        
        currencyViewController?.updateView(viewData: viewData)
    }
}
