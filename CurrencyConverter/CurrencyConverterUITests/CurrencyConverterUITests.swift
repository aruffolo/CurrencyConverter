//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest

class CurrencyConverterUITests: XCTestCase
{
    var app: XCUIApplication!

    override func setUp()
    {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func testAmountConvertedKeepsPlaceholder()
    {
        let convertButton = app.buttons["CONVERT ↓"]
        convertButton.tap()

        let closeButton = app.alerts["Error"].buttons["Close"]
        closeButton.tap()
        convertButton.tap()
        closeButton.tap()

        if let textfieldValue = app.textFields["amountConverted"].value as? String
        {
            XCTAssertTrue(textfieldValue == "Amount converted")
        }

        XCTAssertTrue(app.textFields["amountConverted"].placeholderValue == "Amount converted")
    }
}
