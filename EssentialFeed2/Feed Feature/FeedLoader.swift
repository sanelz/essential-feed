//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 01. 03..
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
