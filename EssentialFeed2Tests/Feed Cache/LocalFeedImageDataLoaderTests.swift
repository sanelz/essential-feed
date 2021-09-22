//
//  LocalFeedImageDataLoaderTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 21..
//

import XCTest
import EssentialFeed2

protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}

final class LocalFeedImageDataLoader: FeedImageDataLoader {
    private struct Task: FeedImageDataLoaderTask {
        func cancel() {}
    }

    enum Error: Swift.Error {
        case failed
    }

    let store: FeedImageDataStore

    init(store: FeedImageDataStore) {
        self.store = store
    }

    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        store.retrieve(dataForURL: url, completion: { _ in
            completion(.failure(Error.failed))
        })
        return Task()
    }
}

class LocalFeedImageDataLoaderTests: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertTrue(store.receivedMessages.isEmpty)
    }

    func test_loadImageDataFromURL_requestsStoreDataForURL() {
        let (sut, store) = makeSUT()
        let url = anyURL()

        _ = sut.loadImageData(from: url) { _ in }

        XCTAssertEqual(store.receivedMessages, [.retrieve(dataFor: url)])
    }

    func test_loadImageDataFromURL_failsOnStoreError() {
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWith: failed(), when: {
            let retrievalError = anyNSError()
            store.complete(with: retrievalError)
        })
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedImageDataLoader, store: StoreSpy) {
        let store = StoreSpy()
        let sut = LocalFeedImageDataLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }

    private func failed() -> LocalFeedImageDataLoader.Result {
        .failure(LocalFeedImageDataLoader.Error.failed)
    }

    private func expect(_ sut: LocalFeedImageDataLoader, toCompleteWith expectedResult: LocalFeedImageDataLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        _ = sut.loadImageData(from: anyURL()) { recievedResult in

            switch (recievedResult, expectedResult) {
                case let (.success(recievedData), .success(expectedData)):
                    XCTAssertEqual(recievedData, expectedData, file: file, line: line)

                case let (.failure(recievedError as LocalFeedImageDataLoader.Error), .failure(expectedError as LocalFeedImageDataLoader.Error)):
                    XCTAssertEqual(recievedError, expectedError, file: file, line: line)

                default:
                    XCTFail("Expected result \(expectedResult), got \(recievedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()
        wait(for: [exp], timeout: 1.0)
    }

    private class StoreSpy: FeedImageDataStore {
        enum Messages: Equatable {
            case retrieve(dataFor: URL)
        }

        private var completions = [(FeedImageDataStore.Result) -> Void]()
        private(set) var receivedMessages = [Messages]()

        func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.Result) -> Void) {
            receivedMessages.append(.retrieve(dataFor: url))
            completions.append(completion)
        }

        func complete(with error: Error, at index: Int = 0) {
            completions[index](.failure(error))
        }
    }
}
