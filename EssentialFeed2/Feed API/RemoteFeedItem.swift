//
//  RemoteFeedItem.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 02. 18..
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
