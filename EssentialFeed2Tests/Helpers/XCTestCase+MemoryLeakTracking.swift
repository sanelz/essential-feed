//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 02. 02..
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
