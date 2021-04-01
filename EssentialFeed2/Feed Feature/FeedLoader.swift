//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 01. 03..
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
