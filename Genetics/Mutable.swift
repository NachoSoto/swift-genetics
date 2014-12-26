//
//  Mutable.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension UIColor {
	func mutate() -> UIColor {
		let components = self.components
		let probability: Float = (1 / 4) * 2

		return UIColor(
			red: roll(probability) ? components.red.mutate().clamp : components.red,
			green: roll(probability) ? components.green.mutate().clamp : components.green,
			blue: roll(probability) ? components.blue.mutate().clamp : components.blue,
			alpha: roll(probability) ? components.alpha.mutate().clamp : components.alpha
		)
	}
}

extension CGFloat {
	func mutate() -> CGFloat {
		let amount = CGFloat(settings.mutationAmount)

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
		let probability = 1 / Float(self.vertices.count)

		return Polygon(vertices: self.vertices.map {
			return roll(probability) ? $0.mutate() : $0
		})
	}
}

private extension UIColor {
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		let components = CGColorGetComponents(CGColor)

		return (components[0], components[1], components[2], components[3])
	}
}