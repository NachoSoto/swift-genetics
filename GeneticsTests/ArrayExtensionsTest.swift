//
//  GeneticsTests.swift
//  GeneticsTests
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Genetics
import XCTest

class GeneticsTests: XCTestCase {
	func testArrayByMergingArrays() {
		let a = [1, 2, 3]
		let b = ["1", "2", "3"]

		let expectedResult = [
			(1, "1"),
			(2, "2"),
			(3, "3")
		]
		let result = Array(zip(a, b))

		XCTAssertEqual(expectedResult.count, countElements(result), "Invalid length")

		for (i, (left, right)) in enumerate(result) {
			XCTAssertEqual(a[i], left)
			XCTAssertEqual(b[i], right)
		}
	}
}
