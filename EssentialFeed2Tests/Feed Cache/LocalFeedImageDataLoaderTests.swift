//
//  LocalFeedImageDataLoaderTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 21..
//

import XCTest
import EssentialFeed2

class LocalFeedImageDataLoaderTests: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertTrue(store.receivedMessages.isEmpty)
    }

    func test_saveImageDataForURL_requestsImageDataInsertionForURL() {
        let (sut, store) = makeSUT()
        let url = anyURL()
        let data = anyData()

        sut.save(data, for: url) { _ in }

        XCTAssertEqual(store.receivedMessages, [.insert(data: data, for: url)])
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

    func test_loadImageDataFromURL_deliversNotFoundErrorOnNotFound() {
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWith: notFound(), when: {
            store.complete(with: .none)
        })
    }

    func test_loadImageDataFromURL_deliversStoredDataOnFoundData() {
        let (sut, store) = makeSUT()
        let foundData = anyData()

        expect(sut, toCompleteWith: .success(foundData), when: {
            store.complete(with: foundData)
        })
    }

    func test_loadImageDataFromURL_doesNotDeliverResultAfterCancellingTask() {
        let (sut, store) = makeSUT()
        let foundData = anyData()

        var receivedData = [FeedImageDataLoader.Result]()
        let task = sut.loadImageData(from: anyURL()) { result in
            receivedData.append(result)
        }
        task.cancel()

        store.complete(with: foundData)
        store.complete(with: .none)
        store.complete(with: anyNSError())

        XCTAssertTrue(receivedData.isEmpty, "Expectec no received results after cancelling task")
    }

    func test_loadImageDataFromURL_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let store = StoreSpy()
        var sut: LocalFeedImageDataLoader? = LocalFeedImageDataLoader(store: store)

        var receivedData = [FeedImageDataLoader.Result]()
        _ = sut?.loadImageData(from: anyURL()) { receivedData.append($0) }

        sut = nil
        store.complete(with: anyData())

        XCTAssertTrue(receivedData.isEmpty, "Expected no received results after instance has been deallocated")
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

    private func notFound() -> LocalFeedImageDataLoader.Result {
        .failure(LocalFeedImageDataLoader.Error.notFound)
    }

    private func never(file: StaticString = #filePath, line: UInt = #line) {
        XCTFail("Expected no no invocations", file: file, line: line)
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
            case insert(data: Data, for: URL)
            case retrieve(dataFor: URL)
        }

        private var completions = [(FeedImageDataStore.Result) -> Void]()
        private(set) var receivedMessages = [Messages]()

        func insert(data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
            receivedMessages.append(.insert(data: data, for: url))
        }

        func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.Result) -> Void) {
            receivedMessages.append(.retrieve(dataFor: url))
            completions.append(completion)
        }

        func complete(with error: Error, at index: Int = 0) {
            completions[index](.failure(error))
        }

        func complete(with data: Data?, at index: Int = 0) {
            completions[index](.success(data))
        }
    }
}
