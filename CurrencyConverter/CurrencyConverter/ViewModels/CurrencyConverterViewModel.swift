//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

class CurrencyConverterViewModel: CurrencyConverterViewModelProtocol
{
    private weak var currencyViewController: CurrencyConverterViewProtocol?
    private var currencyConverter: CurrencyConverterCalculator
    
    private var currenciesRates: [String: Double] = [:]
    private var waitingForFromCurrecyToSet: Bool
    
    private var currencyFrom: String?
    private var currencyTo: String?
    
    var viewData: CurrencyConverterViewData
    let ratesFetcher: CurrencyFetcherProtocol
    
    init(currencyViewController: CurrencyConverterViewProtocol, ratesFetcher: CurrencyFetcherProtocol)
    {
        self.currencyViewController = currencyViewController
        self.ratesFetcher = ratesFetcher
        self.currencyConverter = CurrencyConverterCalculator()
        waitingForFromCurrecyToSet = false
        
        viewData = CurrencyConverterViewData(topAmount: "", topCurrency: "currency", bottomAmount: "", bottomCurrency: "currency")
        
        // TODO: remove it and uses just the currencies from the service
        createStubValues()
        
        currencyConverter.baseCurrency = "EUR"
        currencyConverter.currencies = currenciesRates
    }
    
    private func createStubValues()
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
    
    func viewWillAppear()
    {
        loadData()
    }
    
    func loadData()
    {
        ratesFetcher.latestCurrenciesRates(completion: { [weak self] dataModel in
            self?.receiveRates(ratesResult: dataModel)
        })
    }
    
    func receiveRates(ratesResult: Result<CurrencyDataModel, RatesFetchError>)
    {
        switch ratesResult
        {
        case .success(let model):
            currencyConverter.baseCurrency = model.baseCurrency
            currencyConverter.currencies = model.rates
            currenciesRates = model.rates
        case .failure:
            currencyViewController?.showErrorForDataFailure(title: "Error", message: "Service not available, check internet connection", buttonLabel: "Retry")
            break
        }
    }
    
    func topAmountChanged(amount: String)
    {
        viewData.topAmount = amount
        currencyViewController?.updateView(viewData: viewData)
    }
    
    func selectCurrencyTopButtonPressed()
    {
        waitingForFromCurrecyToSet = true
        currencyViewController?.presentCurrencyPicker(currencies: currenciesRates.keys.sorted())
    }
    
    func selectCurrencyBottomButtonPressed()
    {
        waitingForFromCurrecyToSet = false
        currencyViewController?.presentCurrencyPicker(currencies: currenciesRates.keys.sorted())
    }
    
    func currencyIndexSelected(index: Int)
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
    
    func convertButtonPressed(importToConvert: String)
    {
        guard let number = NumbersUtil.convertStringToDouble(stringNumber: importToConvert) else {
            currencyViewController?.showError(title: "Error", message: "value inserted is not in valid format", buttonLabel: "Close")
            return
        }
        
        guard let currencyFrom = currencyFrom, let currencyTo = currencyTo else {
            currencyViewController?.showError(title: "Error", message: "Please, select both currency to convert value", buttonLabel: "Close")
            return
        }
        
        let valueConverted = currencyConverter.convertCurrencyValue(fromCur: currencyFrom,
                                                                    toCur: currencyTo,
                                                                    valueToConvert: number)
        
        guard let stringConverted = NumbersUtil.converDoubleToFormattedString(importInserted: valueConverted) else {
            currencyViewController?.showError(title: "Error", message: "It was not possible to convert", buttonLabel: "Close")
            return
        }
        
        viewData = CurrencyConverterViewData(topAmount: importToConvert,
                                             topCurrency: currencyFrom,
                                             bottomAmount: stringConverted,
                                             bottomCurrency: currencyTo)
        
        currencyViewController?.updateView(viewData: viewData)
    }
}
