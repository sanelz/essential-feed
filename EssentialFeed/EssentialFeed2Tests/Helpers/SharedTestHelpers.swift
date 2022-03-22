//
//  SharedTestHelpers.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 02. 28..
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}
