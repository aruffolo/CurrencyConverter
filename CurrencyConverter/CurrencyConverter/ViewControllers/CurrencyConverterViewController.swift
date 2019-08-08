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
    
    var showCurrencyList: ((_ currencies: [String]) -> Void)?
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
        viewModel.currencyIndexSelected(index: index)
    }

    func presentCurrencyPicker(currencies: [String])
    {
        showCurrencyList?(currencies)
    }
    
    func updateView(viewData: CurrencyConverterViewData)
    {
        if viewData.topCurrency != nil
        {
            currencyTopLabel.text = viewData.topCurrency
        }
        if viewData.bottomCurrency != nil
        {
            currencyBottomLabel.text = viewData.bottomCurrency
        }

        if viewData.topAmount != nil
        {
            enterAmountTopTextField.text = viewData.topAmount
        }

        if viewData.bottomAmount != nil
        {
            enterAmountBottomTextField.text = viewData.bottomAmount
        }
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
        view.endEditing(true)
        if let amount = enterAmountTopTextField.text
        {
            viewModel.convertButtonPressed(importToConvert: amount)
        }
    }
}
