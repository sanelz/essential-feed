//
//  LocalFeedItem.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 02. 18..
//

import Foundation

public struct LocalFeedImage: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL

    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
