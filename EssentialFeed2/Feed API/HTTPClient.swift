//
//  HTTPClient.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 01. 10..
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
