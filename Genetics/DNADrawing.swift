//
//  DNADrawing.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension DNA {
	public func drawWithSize(size: CGSize, scale: CGFloat) -> UIImage! {
		UIGraphicsBeginImageContextWithOptions(size, true, scale)

		for gene in genes {
			gene.polygon.drawWithSize(size, scale: scale, color: gene.color)
		}

		return UIGraphicsGetImageFromCurrentImageContext()
	}
}

private extension Polygon {
	func drawWithSize(size: CGSize, scale: CGFloat, color: UIColor) {
		let ctx = UIGraphicsGetCurrentContext()
		let denormalizedVertices = map(vertices) { CGPointMake($0.x * size.width, $0.y * size.height) }

		CGContextBeginPath(ctx)

		for (i, vertex) in enumerate(denormalizedVertices) {
			let f = (i == 0) ? CGContextMoveToPoint : CGContextAddLineToPoint

			f(ctx, vertex.x, vertex.y)
		}

		CGContextSetFillColorWithColor(ctx, color.CGColor)
		CGContextFillPath(ctx)
	}
}