//
//  CurrenciesFetcher.swift
//  CurrencyConverter
//
//  Created by Ruffolo Antonio on 08/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol CurrencyFetcherProtocol
{
    func latestCurrenciesRates(completion: @escaping (_ result: Result<CurrencyDataModel, RatesFetchError>) -> Void)
}

enum RatesFetchError: Error
{
    case genericError
}

struct CurrencyFetcher: CurrencyFetcherProtocol
{
    func latestCurrenciesRates(completion: @escaping (_ result: Result<CurrencyDataModel, RatesFetchError>) -> Void)
    {
        APIClient.latestCurrenciesRates(completion: { result in
            switch result
            {
            case .success(let response):
                let model = self.createDataModelFromResponse(response: response)
                completion(Result.success(model))
                break
            case .failure:
                completion(Result.failure(.genericError))
                break
            }
        })
    }
    
    private func createDataModelFromResponse(response: ExchangeRates) -> CurrencyDataModel {
        let date = Date(timeIntervalSince1970: Double(response.timestamp))
        var rates = response.rates
        rates[response.base] = 1
        return CurrencyDataModel(rates: rates, baseCurrency: response.base, updateTime: date)
    }
}
