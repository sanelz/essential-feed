//
//  URLSessionHTTPClientTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 01. 16..
//

import XCTest
import EssentialFeed2

class URLSessionHTTPClientTests: XCTestCase {

    override func tearDown() {
        super.tearDown()

        URLProtocolStub.removeStub()
    }

    func test_getFromURL_performsGETRequestWithURL() {
        let url = anyURL()
        let exp = expectation(description: "Wait for request")

        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }

        makeSUT().get(from: url) { _ in }

        wait(for: [exp], timeout: 1.0)
    }

    func test_canelGetFromURLTask_cancelsURLRequest() {
        let url = anyURL()
        let exp = expectation(description: "Wait for request")

        let task = makeSUT().get(from: url) { result in
            switch result {
                case let .failure(error as NSError) where error.code == URLError.cancelled.rawValue:
                    break

                default:
                    XCTFail("Expected cancelled result, got \(result) instead")
            }
            exp.fulfill()
        }

        task.cancel()
        wait(for: [exp], timeout: 1.0)

        let receivedError = resultErrorFor(taskHandler: { $0.cancel() }) as NSError?

        XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
    }

    func test_getFromURL_failsOnRequestError() {
        let requestError = anyNSError()

        let receivedError = resultErrorFor((data: nil, response: nil, error: requestError)) as NSError?

        XCTAssertEqual(receivedError?.code, requestError.code)
        XCTAssertEqual(receivedError?.domain, requestError.domain)
        XCTAssertNotNil(receivedError)
    }

    func test_getFromURL_failsOnAllInvalidRepresentationCases() {
        XCTAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil)))
        XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: nil)))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: nil)))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: anyHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: nil)))
    }

    func test_getFromURL_succeedsOnHTTPURLResponseWithData() {
        let data = anyData()
        let response = anyHTTPURLResponse()

        let reveivedValues = resultValuesFor((data: data, response: response, error: nil))

        XCTAssertEqual(reveivedValues?.data, data)
        XCTAssertEqual(reveivedValues?.response.url, response.url)
        XCTAssertEqual(reveivedValues?.response.statusCode, response.statusCode)
    }

    func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
        let response = anyHTTPURLResponse()

        let reveivedValues = resultValuesFor((data: nil, response: response, error: nil))

        let emptyData = Data()
        XCTAssertEqual(reveivedValues?.data, emptyData)
        XCTAssertEqual(reveivedValues?.response.url, response.url)
        XCTAssertEqual(reveivedValues?.response.statusCode, response.statusCode)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)

        let sut = URLSessionHTTPClient(session: session)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func resultValuesFor(_ values: (data: Data?, response: URLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)?  {
        let result = resultFor(values, file: file, line: line)

        switch result {
        case let .success((data, response)):
            return (data, response)
        default:
            XCTFail("Expected success got \(result) instead", file: file, line: line)
            return nil
        }
    }

    private func resultErrorFor(_ values: (data: Data?, response: URLResponse?, error: Error?)? = nil, taskHandler: (HTTPClientTask) -> Void = { _ in }, file: StaticString = #filePath, line: UInt = #line) -> Error?  {
        let result = resultFor(values, taskHandler: taskHandler, file: file, line: line)

        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure got \(result) instead", file: file, line: line)
            return nil
        }
    }

    private func resultFor(_ values: (data: Data?, response: URLResponse?, error: Error?)?, taskHandler: (HTTPClientTask) -> Void = { _ in }, file: StaticString = #filePath, line: UInt = #line) -> HTTPClient.Result {
        values.map { URLProtocolStub.stub(data: $0, response: $1, error: $2) }

        let sut = makeSUT(file: file, line: line)
        let exp = expectation(description: "Wait for completion")

        var receivedResult: HTTPClient.Result!
        taskHandler(sut.get(from: anyURL()) { result in
            receivedResult = result
            exp.fulfill()
        })

        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }

    private func anyHTTPURLResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }

    private func nonHTTPURLResponse() -> URLResponse {
        URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
}
