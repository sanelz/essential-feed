//
//  FeedImageViewModel.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 19..
//

public struct FeedImageViewModel<Image> {
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool

    public var hasLocation: Bool {
        location != nil
    }
}
