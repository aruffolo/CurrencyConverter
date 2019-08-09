//
//  AppStrings.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 09/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum AppStrings: String
{
    case error = "error_key"
    case serviceUnavailable = "service_unvailable"
    case retry = "retry"
    case valueFormatError = "value_format_error"
    case close = "close"
    case selectBothCurrency = "select_both_currency"
    case notPossibleToConver = "not_possible_convert"
    case currency = "currency"
    
    var value: String {
        let v = NSLocalizedString(self.rawValue, tableName: "AppMessages", comment: "")
        return v
    }
}
