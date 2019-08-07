//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

protocol CurrencyViewProtocol where Self: UIViewController
{
    var showCurrencyList: (() -> Void)? { get set }
    
    func currencyIndexSelected(index: Int)
}

class CurrencyConverterViewController: UIViewController, CurrencyViewProtocol
{
    @IBOutlet weak var currencyTopLabel: UILabel!
    @IBOutlet weak var currencyBottomLabel: UILabel!
    @IBOutlet weak var enterAmountTopTextField: UITextField!
    @IBOutlet weak var enterAmountBottomTextField: UITextField!
    
    var showCurrencyList: (() -> Void)?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func currencyIndexSelected(index: Int) {
        // TODO
    }
    
    @IBAction func selectCurrencyTopAction(_ sender: UIButton)
    {
        showCurrencyList?()
    }
    
    @IBAction func selectCurrencyBottomAction(_ sender: UIButton)
    {
        showCurrencyList?()
    }
    
    @IBAction func convertAction(_ sender: UIButton)
    {
    }
    
}
