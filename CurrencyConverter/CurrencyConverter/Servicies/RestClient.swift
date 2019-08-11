//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Alamofire

protocol RestProtocol
{
  func latestCurrenciesRates(completion: @escaping (_ result: AFResult<ExchangeRates>) -> Void)
}

class RestClient: RestProtocol
{
  func latestCurrenciesRates(completion: @escaping (_ result: AFResult<ExchangeRates>) -> Void)
  {
    request(RestRouter.latest, completion: completion)
  }

  private func request<T: Codable>(_ urlConvertible: URLRequestConvertible,
                                   completion: @escaping (AFResult<T>) -> Void)
  {
    AF.request(urlConvertible).responseData(completionHandler: { [weak self] (dataResponse: DataResponse<Data>) in
      self?.printResponse(dataResponse)
      let decoder = JSONDecoder()
      let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
      completion(response)
    })
  }

  private func printResponse(_ response: DataResponse<Data>)
  {
    guard let value = try? response.result.get(),
      let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
      else { return }

    print("response is:\n \(string)")
  }
}
