//
//  Mutable.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

private let MutationAmount: Float = 0.1

extension UIColor {
	func mutate() -> UIColor {
		let components = map(self.components) { $0.mutate() }

		return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
	}

	private var components: [CGFloat] {
		let components = CGColorGetComponents(CGColor)
		let componentIndexes = 0..<Int(CGColorGetNumberOfComponents(CGColor))

		return map(componentIndexes) { components[$0] }
	}
}

extension CGFloat {
	func mutate() -> CGFloat {
		let amount = CGFloat(MutationAmount)

		return self + (CGFloat.Random() * 2 * amount) - amount
	}
}

extension CGPoint {
	func mutate() -> CGPoint {
		return CGPoint(x: x.mutate(), y: y.mutate())
	}
}

extension Polygon {
	func mutate() -> Polygon {
		return Polygon(vertices: self.vertices.map { $0.mutate() })
	}
}