//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 07/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator
{
    private weak var rootViewController: CurrencyConverterViewProtocol!
    
    init(rootViewController: CurrencyConverterViewProtocol)
    {
        self.rootViewController = rootViewController
        configureRootController()
    }
    
    private func configureRootController()
    {
        let apiProtocol = APIClient()
        let consistency = ConsistencyClient()
        let ratesFetcher = CurrencyFetcher(consistencyService: consistency, apiProtocol: apiProtocol)
        let currencyViewModel = CurrencyConverterViewModel(currencyViewController: rootViewController,
                                                           ratesFetcher: ratesFetcher)
        rootViewController.viewModel = currencyViewModel

        rootViewController.showCurrencyList = { [weak self] currencies in
            guard let strongSelf = self else { return }
            strongSelf.showCurrencyPickerViewContoller(parentViewController: strongSelf.rootViewController,
                                                       currencies: currencies)
        }
    }
    
    private func showCurrencyPickerViewContoller(parentViewController: UIViewController, currencies: [String])
    {
        let vc = CurrencyPickerViewController.createCurrencyPickerViewController(currencies: currencies)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        configureCurrencyPickerController(currencyPickerController: vc)
        
        parentViewController.present(vc, animated: true, completion: nil)
    }
    
    private func configureCurrencyPickerController(currencyPickerController: CurrencyPickerViewController)
    {
        let viewModel = CurrencyPickerViewModel(view: currencyPickerController)
        currencyPickerController.setViewModel(viewModel: viewModel)
        
        currencyPickerController.currencySelected = { [weak self] index in
            guard let strongSelf = self else { return }

            strongSelf.rootViewController.currencyIndexSelected(index: index)
        }
    }
}
