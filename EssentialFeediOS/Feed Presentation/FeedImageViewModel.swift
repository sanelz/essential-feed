//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 04. 11..
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        location != nil
    }
}
