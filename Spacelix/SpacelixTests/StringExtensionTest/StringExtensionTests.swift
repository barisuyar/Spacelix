//
//  StringExtensionTests.swift
//  SpacelixTests
//
//  Created by BARIS UYAR on 11.03.2022.
//

import XCTest
@testable import Spacelix

final class StringExtensionTests: XCTestCase {

    var testableUrl = "https://www.youtube.com/watch?v=39ninsyTRk8"

    func test_Thumbnail() {
        XCTAssertEqual(testableUrl.thumbnailUrlString, "https://i3.ytimg.com/vi/39ninsyTRk8/hqdefault.jpg")
    }
}
