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
    case consinstencyError
}

struct CurrencyFetcher: CurrencyFetcherProtocol
{
    let cacheDuration: Double = 24

    func latestCurrenciesRates(completion: @escaping (_ result: Result<CurrencyDataModel, RatesFetchError>) -> Void)
    {
        let readCache = cacheShouldBeRead()
        let timeIntervalIsValid = readCache.1
        if let cache = readCache.0, timeIntervalIsValid
        {
            completion(.success(cache))
        }
        else
        {
            // if this fails then try to use the cached data
            APIClient.latestCurrenciesRates(completion: { result in
                switch result
                {
                case .success(let response):
                    let model = self.createDataModelFromResponse(response: response)
                    // If I'm here it means that cache is invalid or not saved yet. I must save it
                    ConsistencyClient.setRates(currencyModel: model)
                    completion(Result.success(model))
                    break
                case .failure:
                    completion(Result.failure(.genericError))
                    break
                }
            })
        }
    }

    private func cacheShouldBeRead() -> (CurrencyDataModel?, Bool)
    {
        let tuple = cacheShouldBeWritten()
        return (tuple.0, !tuple.1)
    }
    
    private func cacheShouldBeWritten() -> (CurrencyDataModel?, Bool)
    {
        let currentDate = Date()
        if let rates = ConsistencyClient.getRates() {
            let cacheDate = rates.updateTime
            let difference: TimeInterval = currentDate.timeIntervalSince(cacheDate)
            let hoursDifference = difference / 3600
            
            return (rates, hoursDifference > cacheDuration)
        }
        
        return (nil, true)
    }
    
    private func createDataModelFromResponse(response: ExchangeRates) -> CurrencyDataModel {
        let date = Date(timeIntervalSince1970: Double(response.timestamp))
        var rates = response.rates
        rates[response.base] = 1
        return CurrencyDataModel(rates: rates, baseCurrency: response.base, updateTime: date)
    }
}
