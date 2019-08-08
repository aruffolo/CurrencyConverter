//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Alamofire

class APIClient {

  static func latestCurrenciesRates(completion: @escaping (_ result: AFResult<ExchangeRates>) -> Void)
  {
    // this is just to test result, error handling should be take care of by caller
//    request(ApiRouter.latest, completion: { (afResult: AFResult<ExchangeRates>) in
//      switch afResult {
//      case .success(let exchanges):
//
//        break
//      case .failure(let error):
//        break
//      }
//    })

    request(ApiRouter.latest, completion: completion)
  }

  private static func request<T: Codable>(_ urlConvertible: URLRequestConvertible,
                                           completion: @escaping (AFResult<T>) -> Void)
  {
    AF.request(urlConvertible).responseData(completionHandler:{ (dataResponse: DataResponse<Data>) in
      printResponse(dataResponse)
      let decoder = JSONDecoder()
      let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
      completion(response)
    })
  }

  private static func printResponse(_ response: DataResponse<Data>)
  {
    guard let value = try? response.result.get(),
      let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
      else { return }

    print("response is:\n \(string)")
  }
}
