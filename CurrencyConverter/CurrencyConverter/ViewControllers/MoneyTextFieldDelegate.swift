//
//  MoneyTextFieldDelegate.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

class MoneyTextFieldDelegate: NSObject, UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
