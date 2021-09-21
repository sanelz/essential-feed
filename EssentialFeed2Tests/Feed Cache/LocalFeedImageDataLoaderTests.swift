//
//  LocalFeedImageDataLoaderTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 21..
//

import XCTest
import EssentialFeed2

final class LocalFeedImageDataLoader {
    init(store: Any) {

    }
}

class LocalFeedImageDataLoaderTests: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertTrue(store.receivedMessages.isEmpty)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedImageDataLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedImageDataLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }

    private class FeedStoreSpy {
        let receivedMessages = [Any]()
    }
}
