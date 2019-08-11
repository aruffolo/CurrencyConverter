//
//  ApiRouter.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import Alamofire

private enum Constants
{
  static let baseURLPath = "http://data.fixer.io/api"
  static let apiKey = "77fe6adc45afe7abbdbde5b813238dc2"
}

private enum EndPoints: String
{
  case latest = "/latest"
}

private struct RestParameterKey
{
  static let accessKey = "access_key"
}

public enum RestRouter: URLRequestConvertible
{
  case latest

  var method: HTTPMethod
  {
    switch self
    {
    case .latest:
      return .get
    }
  }

  var path: String
  {
    switch self
    {
    case .latest:
      return EndPoints.latest.rawValue
    }
  }

  var parameters: Parameters?
  {
    switch self
    {
    case .latest:
      return [RestParameterKey.accessKey: Constants.apiKey]
    }
  }

  var encoding: ParameterEncoding
  {
    switch method
    {
    case .get:
      return URLEncoding.default
    default:
      return JSONEncoding.default
    }
  }

  public func asURLRequest() throws -> URLRequest
  {
    let url = try Constants.baseURLPath.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))

    // HTTP Method
    urlRequest.httpMethod = method.rawValue

    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

    if method == .post
    {
      return try createPostUrlRequest(urlRequest: &urlRequest)
    }
    else
    {
      let finalRerquest = try encoding.encode(urlRequest, with: parameters)
      print("GET request url\n: \(String(describing: finalRerquest.url?.absoluteString))")
      return finalRerquest
    }
  }

  private func createPostUrlRequest(urlRequest: inout URLRequest) throws -> URLRequest
  {
    if let parameters = parameters
    {
      do
      {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      }
      catch
      {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    return urlRequest
  }
}
