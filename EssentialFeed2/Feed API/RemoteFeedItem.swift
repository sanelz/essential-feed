//
//  RemoteFeedItem.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 02. 18..
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
