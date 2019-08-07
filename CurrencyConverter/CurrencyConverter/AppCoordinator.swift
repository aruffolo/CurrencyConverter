//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    private weak var rootViewController: CurrencyViewProtocol!
    
    init(rootViewController: CurrencyViewProtocol)
    {
        self.rootViewController = rootViewController
        configureRootController()
    }
    
    private func configureRootController()
    {
        rootViewController.showCurrencyList = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showCurrencyPickerViewContoller(parentViewController: strongSelf.rootViewController)
        }
    }
    
    private func showCurrencyPickerViewContoller(parentViewController: UIViewController)
    {
        let vc = CurrencyPickerViewController.createCurrencyPickerViewController(currencies: ["EUR", "USD"])
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        configureCurrencyController(currencyController: vc)
        
        parentViewController.present(vc, animated: true, completion: nil)
    }
    
    private func configureCurrencyController(currencyController: CurrencyPickerViewController)
    {
        currencyController.currencySelected = { [weak self] index in
            guard let strongSelf = self else { return }
            
            print("index arrived: \(index)")
            
            strongSelf.rootViewController.currencyIndexSelected(index: index)
        }
    }
}
