//
//  MagicTests.swift
//  MagicTests
//
//  Created by Kishikawa Katsumi on 2018/12/23.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import XCTest
@testable import Magic

class MagicTests: XCTestCase {
    func testDescription() {
        do {
            guard let filePath = Bundle(for: MagicTests.self).url(forResource: "Info", withExtension: "plist") else {
                fatalError()
            }
            XCTAssertEqual(try! Magic.shared.file(filePath), "Apple binary property list")
        }
    }
    
    func testMimeType() {
        do {
            guard let filePath = Bundle(for: MagicTests.self).url(forResource: "Info", withExtension: "plist") else {
                fatalError()
            }
            XCTAssertEqual(try! Magic.shared.file(filePath, flags: .mime), "application/octet-stream; charset=binary")
        }
    }
}
