//
//  CurrencyViewControllerMock.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 09/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit
@testable import CurrencyConverter

class CurrencyViewControllerMock: UIViewController, CurrencyConverterViewProtocol
{
  var viewModel: CurrencyConverterViewModelProtocol!
  
  var showCurrencyList: (([String]) -> Void)?
  
  var topCurrency: String?
  var topAmount: String?
  var bottomCurrency: String?
  var bottomAmount: String?
  
  var errorInFetchingData: Bool = false
  
  func callLoadDataForViewModel()
  {
    viewModel.loadData()
  }
  
  func currencyIndexSelected(index: Int)
  {
    
  }
  
  func presentCurrencyPicker(currencies: [String])
  {
    
  }
  
  func updateView(viewData: CurrencyConverterViewData)
  {
    topCurrency = viewData.topCurrency
    topAmount = viewData.topAmount
    bottomAmount = viewData.bottomAmount
    bottomCurrency = viewData.bottomCurrency
  }
  
  func showError(title: String, message: String, buttonLabel: String)
  {
    
  }
  
  func showErrorForDataFailure(title: String, message: String, buttonLabel: String)
  {
    errorInFetchingData = true
  }
}
