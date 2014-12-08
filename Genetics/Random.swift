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
		return CGFloat(Float.Random())
	}
}

extension Float {
	static func Random() -> Float {
		return Float(arc4random()) /  Float(UInt32.max)
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