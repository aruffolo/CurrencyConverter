//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController, CurrencyConverterViewProtocol
{
    @IBOutlet weak var currencyTopLabel: UILabel!
    @IBOutlet weak var currencyBottomLabel: UILabel!
    @IBOutlet weak var enterAmountTopTextField: UITextField!
    @IBOutlet weak var enterAmountBottomTextField: UITextField!
    
    var viewModel: CurrencyConverterViewModelProtocol!
    
    var showCurrencyList: (() -> Void)?
    let textFieldDelegate = MoneyTextFieldDelegate()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        enterAmountTopTextField.delegate = textFieldDelegate
    }
    
    // this should call the view model
    func currencyIndexSelected(index: Int)
    {
        print("index arrived: \(index)")
    }
    
    func setCurrencyConversion(currencyConverted: String)
    {
        enterAmountBottomTextField.text = currencyConverted
    }
    
    func presentCurrencyPicker()
    {
        showCurrencyList?()
    }
    
    @IBAction func selectCurrencyTopAction(_ sender: UIButton)
    {
        viewModel.selectCurrencyTopButtonPressed()
    }
    
    @IBAction func selectCurrencyBottomAction(_ sender: UIButton)
    {
        viewModel.selectCurrencyBottomButtonPressed()
    }
    
    @IBAction func convertAction(_ sender: UIButton)
    {
        if let amount = enterAmountTopTextField.text
        {
            viewModel.convertButtonPressed(importToConvert: amount)
        }
    }
}
