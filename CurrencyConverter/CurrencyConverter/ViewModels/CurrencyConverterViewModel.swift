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
    
    init(currencyViewController: CurrencyConverterViewProtocol)
    {
        self.currencyViewController = currencyViewController
    }
    
    // TODO: call service to retrieve list of exchanger rates

    func selectCurrencyTopButtonPressed()
    {
        currencyViewController?.presentCurrencyPicker()
    }
    
    func selectCurrencyBottomButtonPressed()
    {
        currencyViewController?.presentCurrencyPicker()
    }
    
    func convertButtonPressed(importToConvert: String)
    {
        guard let number = NumbersUtil.convertStringToDouble(stringNumber: importToConvert) else {
            // TODO: show error
            return
        }

        // TODO: the brain should convert the number and give it to the view
        currencyViewController?.setCurrencyConversion(currencyConverted: "converted number")
    }
}
