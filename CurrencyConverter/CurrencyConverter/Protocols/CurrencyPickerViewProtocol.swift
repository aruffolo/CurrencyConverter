//
//  CurrencyPickerViewProtocol.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyPickerViewProtocol where Self: UIViewController
{
    func closeView()
    func closeWithIndexSelected(index: Int)
}
