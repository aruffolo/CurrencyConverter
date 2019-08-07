//
//  CurrencyPickerViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyPickerViewModelProtocol
{
    mutating func indexChanged(index: Int)

    func cancelButtonPressed()

    func doneButtonPressed()
}
