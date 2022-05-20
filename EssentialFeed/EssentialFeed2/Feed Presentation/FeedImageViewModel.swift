//
//  FeedImageViewModel.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 19..
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        location != nil
    }
}
