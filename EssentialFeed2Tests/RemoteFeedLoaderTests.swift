//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 01. 04..
//

import XCTest

class RemoteFeedLoader {
     
}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromTheURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
