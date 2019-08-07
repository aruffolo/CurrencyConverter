//
//  CurrencyPickerViewModel.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct CurrencyPickerViewModel: CurrencyPickerViewModelProtocol
{
    private weak var view: CurrencyPickerViewProtocol?
    private var indexSelected: Int
    
    init(view: CurrencyPickerViewProtocol)
    {
        self.view = view
        indexSelected = 0
    }
    
    mutating func indexChanged(index: Int)
    {
        self.indexSelected = index
    }

    func cancelButtonPressed()
    {
        view?.closeView()
    }
    
    func doneButtonPressed()
    {
        view?.closeWithIndexSelected(index: indexSelected)
    }
}
