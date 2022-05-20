//
//  FeedImagePresenterTests.swift
//  EssentialFeed2Tests
//
//  Created by mbp01 on 2021. 09. 18..
//

import XCTest
import EssentialFeed2

class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
