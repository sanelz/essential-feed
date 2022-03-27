import XCTest
import EssentialFeed2

protocol FeedLoaderTestCase: XCTestCase {}

extension FeedLoaderTestCase {
    func expect(_ sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResut in
            switch (receivedResut, expectedResult) {
            case let (.success(receivedFeed), .success(expectedFeed)):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResut) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}
