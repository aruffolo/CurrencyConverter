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
    @IBOutlet weak var selectCurrencyTop: UIButton!
    @IBOutlet weak var selectCurrencyBottom: UIButton!
    @IBOutlet weak var convertButton: UIButton!

    var viewModel: CurrencyConverterViewModelProtocol!
    
    var showCurrencyList: ((_ currencies: [String]) -> Void)?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        enterAmountTopTextField.delegate = self
        enterAmountTopTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()

        setStyle()
    }

    private func setStyle()
    {
        setShadows()
        setCornerRadius()

        convertButton.layer.borderWidth = 2
        convertButton.layer.borderColor = UIColor.init(red: 5/255, green: 100/255, blue: 255/255, alpha: 1.0).cgColor
    }

    private func setShadows()
    {
        setShadow(layer: selectCurrencyTop.layer)
        setShadow(layer: selectCurrencyBottom.layer)
        setShadow(layer: convertButton.layer)
    }

    private func setCornerRadius()
    {
        selectCurrencyTop.layer.cornerRadius = selectCurrencyTop.frame.height / 2
        selectCurrencyBottom.layer.cornerRadius = selectCurrencyTop.frame.height / 2

        convertButton.layer.cornerRadius = convertButton.frame.height / 2
    }

    private func setShadow(layer: CALayer)
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
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
        currencyTopLabel.text = viewData.topCurrency
        currencyBottomLabel.text = viewData.bottomCurrency

        enterAmountTopTextField.text = viewData.topAmount
        enterAmountBottomTextField.text = viewData.bottomAmount
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
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        viewModel.topAmountChanged(amount: textField.text ?? "")
    }
    
    func showErrorForDataFailure(title: String, message: String, buttonLabel: String)
    {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: buttonLabel,
                                                style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.viewModel.loadData()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }

    func showError(title: String, message: String, buttonLabel: String)
    {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonLabel, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        viewModel.topAmountChanged(amount: textField.text ?? "")

        return true
    }
}
