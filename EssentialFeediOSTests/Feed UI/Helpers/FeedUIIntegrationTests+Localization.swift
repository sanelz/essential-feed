//
//  FeedUIIntegrationTests+Localization.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 18..
//

import Foundation
import XCTest
import EssentialFeed2

extension FeedUIIntegrationTests {
    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
