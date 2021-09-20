//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 20..
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { 200 }

    var isOK: Bool {
        statusCode == HTTPURLResponse.OK_200
    }
}
