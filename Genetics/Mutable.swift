//
//  Mutable.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

private let MutationAmount: Float = 0.01

extension UIColor {
	func mutate() -> UIColor {
		let components = self.components

		return UIColor(red: components.red.mutate().clamp, green: components.green.mutate().clamp, blue: components.blue.mutate().clamp, alpha: components.alpha.mutate().clamp)
	}
}

extension CGFloat {
	func mutate() -> CGFloat {
		let amount = CGFloat(MutationAmount)

		return self + (CGFloat.Random() * 2 * amount) - amount
	}

	var clamp: CGFloat {
		return fmin(fmax(self, 0.0), 1.0)
	}
}

extension CGPoint {
	func mutate() -> CGPoint {
		return CGPoint(x: x.mutate().clamp, y: y.mutate().clamp)
	}
}

extension Polygon {
	func mutate() -> Polygon {
		return Polygon(vertices: self.vertices.map { $0.mutate() })
	}
}

private extension UIColor {
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		let components = CGColorGetComponents(CGColor)

		return (components[0], components[1], components[2], components[3])
	}
}