//
//  NumbersUtil.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

class NumbersUtil
{
    class func convertStringToDouble(stringNumber: String) -> Double?
    {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        guard let number = formatter.number(from: stringNumber) else { return nil }
        
        return Double(truncating: number)
    }
    
    class func converDoubleToFormattedString(importInserted: Double) -> String?
    {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale.current

        return currencyFormatter.string(from: NSNumber(value: importInserted))
    }
}
