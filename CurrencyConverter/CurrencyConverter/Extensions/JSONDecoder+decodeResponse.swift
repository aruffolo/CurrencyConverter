//
//  JSONDecoder+decodeResponse.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import Alamofire

extension JSONDecoder
{
  func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> AFResult<T>
  {
    guard response.error == nil else
    {
      print("response returned error: \(response.error!)")
      return .failure(response.error!)
    }

    guard let responseData = response.data else
    {
      print("didn't get any data from API")
      return .failure(BackendError.parsing(reason:
        "Did not get data in response"))
    }

    do
    {
      let item = try decode(T.self, from: responseData)
      return .success(item)
    }
    catch
    {
      print("error trying to decode response: \(error)")
      return .failure(error)
    }
  }
}

enum BackendError: Error
{
  case parsing(reason: String)
}
