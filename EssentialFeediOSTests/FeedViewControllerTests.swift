//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by mbp01 on 2021. 04. 04..
//

import XCTest

final class FeedViewController {
    init(loader: FeedViewControllerTests.LoaderSpy) {

    }
}

class FeedViewControllerTests: XCTestCase {

    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)

        XCTAssertEqual(loader.loadCallCount, 0)
    }

    // MARK: - Helpers

    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }
}

