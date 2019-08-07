//
//  CurrencyPickerViewController.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UIViewController
{
    @IBOutlet weak var pickerView: UIPickerView!
    
    var currencies: [String]!
    var currencySelected: ((_ index: Int) -> Void)?
    var indexSelected: Int = 0
    
    static func createCurrencyPickerViewController(currencies: [String]) -> CurrencyPickerViewController
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as? CurrencyPickerViewController else {
            fatalError("This must be a CurrencyPickerViewController")
        }
        vc.currencies = currencies
        
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initPickerView()
    }
    
    private func initPickerView()
    {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: {
            self.currencySelected?(self.indexSelected)
        })
    }
    
    deinit
    {
        print("CurrencyPickerViewController deinit called")
    }
}

extension CurrencyPickerViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return currencies[row]
    }
}

extension CurrencyPickerViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print("row selected: \(row)")
        indexSelected = row
    }
}

