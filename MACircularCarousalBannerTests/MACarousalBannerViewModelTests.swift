//
//  MACarousalBannerViewModelTests.swift
//  MACircularCarousalBannerTests
//
//  Created by Alam, Mahjabin | Natasha | ECMPD on 2023/02/23.
//

import XCTest
@testable import MACircularCarousalBanner

final class MACarousalBannerViewModelTests: XCTestCase {

    var sut: MACarousalBannerViewModel!
    let images = ["img_1", "img_2", "img_3"]
    
    override func setUp() {
        super.setUp()
        sut = MACarousalBannerViewModel(imageNames: images)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testImageList() {
        XCTAssertEqual(sut.imageList().count, 2)
    }

}
