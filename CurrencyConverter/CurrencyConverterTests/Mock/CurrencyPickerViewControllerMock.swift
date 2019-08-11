//
//  CurrencyPickerViewControllerMock.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 10/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
@testable import CurrencyConverter

class CurrencyPickerViewControllerMock: UIViewController, CurrencyPickerViewProtocol
{
  var closePressed: Bool = false
  var indexSelectedArrived: Int = 0
  
  func closeView()
  {
    closePressed = true
  }
  
  func closeWithIndexSelected(index: Int)
  {
    indexSelectedArrived = index
  }
}
