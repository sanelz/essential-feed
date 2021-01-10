//
//  FeedItem.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 01. 03..
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
