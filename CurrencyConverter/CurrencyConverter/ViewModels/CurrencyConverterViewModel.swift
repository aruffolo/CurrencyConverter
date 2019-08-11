//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum ConverterError: Error {
  case valueNotFormatted
  case bothCurrencyNotSelected
  case impossibleToConvert
}

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

    viewData = CurrencyConverterViewData(topAmount: "",
                                         topCurrency: AppStrings.currency.value,
                                         bottomAmount: "",
                                         bottomCurrency: AppStrings.currency.value)

    currencyConverter.currencies = currenciesRates
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
      currencyConverter.currencies = model.rates
      currenciesRates = model.rates
    case .failure:
      currencyViewController?.showErrorForDataFailure(title: AppStrings.error.value,
                                                      message: AppStrings.serviceUnavailable.value,
                                                      buttonLabel: AppStrings.retry.value)
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
    let result = checkForConversionError(importToConvert: importToConvert)

    switch result
    {
    case .success(let viewData):
      self.viewData = viewData
      currencyViewController?.updateView(viewData: viewData)
    case .failure(let error):
      showAlertFromError(error: error)
    }
  }

  private func showAlertFromError(error: ConverterError)
  {
    switch error {
    case .valueNotFormatted:
      currencyViewController?.showError(title: AppStrings.error.value, message: AppStrings.valueFormatError.value,
                                        buttonLabel: AppStrings.close.value)
    case .bothCurrencyNotSelected:
        currencyViewController?.showError(title: AppStrings.error.value, message: AppStrings.selectBothCurrency.value,
                                          buttonLabel: AppStrings.close.value)
    case .impossibleToConvert:
      currencyViewController?.showError(title: AppStrings.error.value, message: AppStrings.notPossibleToConver.value,
                                        buttonLabel: AppStrings.close.value)
    }
  }

  private func checkForConversionError(importToConvert: String) -> Result<CurrencyConverterViewData, ConverterError>
  {
    guard let number = NumbersUtil.convertStringToDouble(stringNumber: importToConvert) else {
      return Result.failure(.valueNotFormatted)
    }

    guard let currencyFrom = currencyFrom, let currencyTo = currencyTo else {
      return Result.failure(.bothCurrencyNotSelected)
    }

    let valueConverted = currencyConverter.convertCurrencyValue(fromCur: currencyFrom, toCur: currencyTo,
                                                                valueToConvert: number)
    guard let stringConverted = NumbersUtil.converDoubleToFormattedString(importInserted: valueConverted) else {
      return Result.failure(.impossibleToConvert)
    }

    let viewData = CurrencyConverterViewData(topAmount: importToConvert, topCurrency: currencyFrom,
                                         bottomAmount: stringConverted, bottomCurrency: currencyTo)

    return Result.success(viewData)
  }
}
