//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase
{
  let eurCur: String = "EUR"
  let usdCur: String = "USD"
  
  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown()
  {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testConversion()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.selectCurrencyTopButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 4)
    currencyViewModel.selectCurrencyBottomButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 7)

    let numberConverted = NumbersUtil.converDoubleToFormattedString(importInserted: 1.234)
    
    currencyViewModel.convertButtonPressed(importToConvert: "1")
    XCTAssert(viewController.bottomAmount == numberConverted
      && viewController.bottomCurrency == usdCur
      && viewController.topCurrency == eurCur
      && viewController.topAmount == "1")
  }
  
  func testFormatError()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.selectCurrencyTopButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 4)
    currencyViewModel.selectCurrencyBottomButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 7)
    
    currencyViewModel.convertButtonPressed(importToConvert: "abc")
    // this means that the conversion has not taken place
    XCTAssert(viewController.bottomAmount == ""
      && viewController.topCurrency == eurCur
      && viewController.bottomCurrency == usdCur
      && viewController.topAmount == "")
  }
  
  func testTopCurrencyNotSelected()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.selectCurrencyBottomButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 7)
    
    currencyViewModel.convertButtonPressed(importToConvert: "1")
    // this means that the conversion has not taken place
    XCTAssert(viewController.bottomAmount == ""
      && viewController.bottomCurrency == usdCur
      && viewController.topCurrency == AppStrings.currency.value)
  }
  
  func testBottomCurrencyNotSelected()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.selectCurrencyTopButtonPressed()
    currencyViewModel.currencyIndexSelected(index: 4)
    
    currencyViewModel.convertButtonPressed(importToConvert: "1")
    // this means that the conversion has not taken place
    XCTAssert(viewController.bottomAmount == ""
      && viewController.bottomCurrency == AppStrings.currency.value
      && viewController.topCurrency == eurCur)
  }
  
  func testBothCurrenciesNotSelected()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController, ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.convertButtonPressed(importToConvert: "1")
    // this means that the conversion has not taken place
    XCTAssert(viewController.bottomAmount == nil
      && viewController.bottomCurrency == nil
      && viewController.topCurrency == nil)
  }
  
  func testTopImportChanged()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    currencyViewModel.topAmountChanged(amount: "1234")
    
    XCTAssert(viewController.topAmount == "1234")
  }
  
  func testFetchDataError()
  {
    let viewController = CurrencyViewControllerMock()
    let currencyFetcher = CurrencyFetcherFailMock()
    
    let currencyViewModel = CurrencyConverterViewModel(currencyViewController: viewController,
                                                       ratesFetcher: currencyFetcher)
    viewController.viewModel = currencyViewModel
    viewController.callLoadDataForViewModel()
    
    XCTAssert(viewController.errorInFetchingData)
  }
}
