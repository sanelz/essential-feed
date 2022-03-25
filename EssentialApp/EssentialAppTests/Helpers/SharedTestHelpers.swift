import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://a-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}