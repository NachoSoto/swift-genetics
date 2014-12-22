//
//  DNADrawing.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension DNA {
	public func drawWithSize(size: CGSize, inContext context: CGContextRef) {
		for gene in genes {
			gene.polygon.drawWithSize(size, color: gene.color, inContext: context)
		}
	}
}

private extension Polygon {
	func drawWithSize(size: CGSize, color: UIColor, inContext context: CGContextRef) {
		let denormalizedVertices = map(vertices) { CGPointMake($0.x * size.width, $0.y * size.height) }

		CGContextBeginPath(context)

		for (i, vertex) in enumerate(denormalizedVertices) {
			let f = (i == 0) ? CGContextMoveToPoint : CGContextAddLineToPoint

			f(context, vertex.x, vertex.y)
		}

		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillPath(context)
	}
}

extension DNA {
	public func imageWithSize(size: CGSize, scale: CGFloat) -> UIImage! {
		UIGraphicsBeginImageContextWithOptions(size, true, scale)

		drawWithSize(size, inContext: UIGraphicsGetCurrentContext())
		let image = UIGraphicsGetImageFromCurrentImageContext()

		UIGraphicsEndImageContext()

		return image
 	}
}

