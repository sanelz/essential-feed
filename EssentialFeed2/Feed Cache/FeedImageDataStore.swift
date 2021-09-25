//
//  FeedImageDataStore.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 25..
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
