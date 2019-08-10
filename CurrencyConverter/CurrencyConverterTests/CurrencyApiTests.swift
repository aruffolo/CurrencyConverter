//
//  CurrencyApiTests.swift
//  CurrencyConverterTests
//
//  Created by Antonio Ruffolo on 10/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyApiTests: XCTestCase
{
    override func setUp()
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRealService()
    {
        let api = RestClient()
        let consistencyService = ConsistencyServiceMock(shouldHaveCache: false)
        let fetcher = CurrencyFetcher(consistencyService: consistencyService, apiProtocol: api)

        let completedExpectation = expectation(description: "Completed")

        fetcher.latestCurrenciesRates(completion: { result in
            switch result
            {
                case .success(_):
                    completedExpectation.fulfill()
                    XCTAssert(true)
                    break
                case .failure(_):
                    completedExpectation.fulfill()
                    XCTFail("response should have arrived")
                    break
            }
        })

        waitForExpectations(timeout: 5, handler: { error in
            if (error != nil)
            {
                XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
            }
        })
    }

    func testDataFromCache()
    {
        let api = RestClient()
        let consistencyService = ConsistencyServiceMock(shouldHaveCache: true)
        let fetcher = CurrencyFetcher(consistencyService: consistencyService, apiProtocol: api)

        let completedExpectation = expectation(description: "Completed")

        fetcher.latestCurrenciesRates(completion: { result in
            switch result
            {
            case .success(_):
                completedExpectation.fulfill()
                XCTAssert(true)
                break
            case .failure(_):
                completedExpectation.fulfill()
                XCTFail("response should have arrived")
                break
            }
        })

        waitForExpectations(timeout: 5, handler: { error in
            if (error != nil)
            {
                XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
            }
        })
    }

    func testServiceFailing()
    {
        let api = ApiMock(failing: true, responseInvalid: false)
        let consistencyService = ConsistencyServiceMock(shouldHaveCache: false)
        let fetcher = CurrencyFetcher(consistencyService: consistencyService, apiProtocol: api)

        let completedExpectation = expectation(description: "Completed")

        fetcher.latestCurrenciesRates(completion: { result in
            switch result
            {
            case .success(_):
                completedExpectation.fulfill()
                XCTFail("response should have arrived")
                break
            case .failure(let error):
                completedExpectation.fulfill()
                XCTAssert(error == RatesFetchError.genericError)
            }
        })

        waitForExpectations(timeout: 5, handler: { error in
            if (error != nil)
            {
                XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
            }
        })
    }

    func testServiceFailingButCachePresent()
    {
        let api = ApiMock(failing: true, responseInvalid: false)
        let consistencyService = ConsistencyServiceMock(shouldHaveCache: true)
        let fetcher = CurrencyFetcher(consistencyService: consistencyService, apiProtocol: api)

        let completedExpectation = expectation(description: "Completed")

        fetcher.latestCurrenciesRates(completion: { result in
            switch result
            {
            case .success(_):
                completedExpectation.fulfill()
                XCTAssert(true)
            case .failure(_):
                completedExpectation.fulfill()
                XCTFail("response should have arrived")
            }
        })

        waitForExpectations(timeout: 5, handler: { error in
            if (error != nil)
            {
                XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
            }
        })
    }

    func testResponseInvalid()
    {
        let api = ApiMock(failing: false, responseInvalid: true)
        let consistencyService = ConsistencyServiceMock(shouldHaveCache: false)
        let fetcher = CurrencyFetcher(consistencyService: consistencyService, apiProtocol: api)

        let completedExpectation = expectation(description: "Completed")

        fetcher.latestCurrenciesRates(completion: { result in
            switch result
            {
            case .success(_):
                completedExpectation.fulfill()
                XCTFail("response should have arrived")
            case .failure(let error):
                completedExpectation.fulfill()
                XCTAssert(error == RatesFetchError.responseInvalidError)
            }
        })

        waitForExpectations(timeout: 5, handler: { error in
            if (error != nil)
            {
                XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
            }
        })
    }
}
