//
//  Random.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension UIColor {
	class func Random() -> UIColor {
		let components = map(0..<4) { _ in CGFloat.Random() }

		return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
	}
}

extension CGPoint {
	static func Random() -> CGPoint {
		return CGPoint(x: CGFloat.Random(), y: CGFloat.Random())
	}
}

extension CGFloat {
	static func Random() -> CGFloat {
		return CGFloat(arc4random()) /  CGFloat(UInt32.max)
	}
}

extension Float {
	static func Random() -> Float {
		return Float(CGFloat.Random())
	}
}

extension Bool {
	static func Random() -> Bool {
		return arc4random() % 2 == 0
	}
}

func roll(probability: Float) -> Bool {
	return Float.Random() < probability
}

extension Array {
	var randomElement: T {
		return self[(0..<count).randomInt]
	}
}

func randomElementInArray<T: Equatable>(array: [T], except exception: T) -> T {
	precondition(array.count > 1)

	var result = array.first!

	while (result == exception) {
		result = array.randomElement
	}

	return result
}


extension Range {
	var randomInt: Int {
		var offset = 0

		if (startIndex as Int) < 0 {
			offset = abs(startIndex as Int) // allow negative ranges
		}

		let mini = UInt32(startIndex as Int + offset)
		let maxi = UInt32(endIndex   as Int + offset)

		return Int(mini + arc4random_uniform(maxi - mini)) - offset
	}
}

