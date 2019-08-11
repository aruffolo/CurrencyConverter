//
//  CurrencyPickerTests.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 10/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyPickerTests: XCTestCase
{
  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown()
  {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testClosePressed()
  {
    let viewController = CurrencyPickerViewControllerMock()
    let pickerViewModel = CurrencyPickerViewModel(view: viewController)
    
    pickerViewModel.cancelButtonPressed()
    
    XCTAssert(viewController.closePressed)
  }
  
  func testCloseWithIndexPressed()
  {
    let viewController = CurrencyPickerViewControllerMock()
    var pickerViewModel = CurrencyPickerViewModel(view: viewController)
    
    pickerViewModel.indexChanged(index: 19)
    pickerViewModel.doneButtonPressed()
    
    XCTAssert(viewController.indexSelectedArrived == 19)
  }
}
