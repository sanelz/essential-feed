//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 01. 03..
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
