//
//  FeedPresentationTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 17..
//

import XCTest

final class FeedPresenter {
    init(view: Any) {

    }
}

class FeedPresentationTests: XCTestCase {

    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpy()

        _ = FeedPresenter(view: view)

        XCTAssertTrue(view.messages.isEmpty, "Expect no view messages")
    }

    // MARK: - Helpers

    private class ViewSpy {
        let messages = [Any]()
    }
}
