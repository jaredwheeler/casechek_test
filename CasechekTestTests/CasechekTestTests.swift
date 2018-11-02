//
//  CasechekTestTests.swift
//  CasechekTestTests
//
//  Created by Jared Wheeler on 11/1/18.
//  Copyright © 2018 Jared Wheeler. All rights reserved.
//

import XCTest
@testable import CasechekTest

class CasechekTestTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testISO8601DateFormatter() {
        let y = "2018"
        let mo = "10"
        let d = "01"
        let h = "14"
        let mi = "05"
        let s = "57"
        let ms = "017"
        let dateString = y+"-"+mo+"-"+d+"T"+h+":"+mi+":"+s+"."+ms
        let date = Formatter.dateFrom(IS08601String: dateString)
        let calendar = Calendar.current
        assert(date != nil)
        assert(calendar.component(.year, from: date!) == Int(y))
        assert(calendar.component(.month, from: date!) == Int(mo))
        assert(calendar.component(.day, from: date!) == Int(d))
        assert(calendar.component(.hour, from: date!) == Int(h))
        assert(calendar.component(.minute, from: date!) == Int(mi))
        assert(calendar.component(.second, from: date!) == Int(s))
    }

    func testPerformanceExample() {
        self.measure { }
    }

}
