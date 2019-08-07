//
//  CurrencyConverterViewProtocol.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyConverterViewProtocol where Self: UIViewController
{
    var viewModel: CurrencyConverterViewModelProtocol! { get set }
    
    var showCurrencyList: (() -> Void)? { get set }
    func currencyIndexSelected(index: Int)
    
    func setCurrencyConversion(currencyConverted: String)
    func presentCurrencyPicker()
}
