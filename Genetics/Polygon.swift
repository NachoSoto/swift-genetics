//
//  Polygon.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct Polygon {
	public let vertices: [CGPoint]

	public init(vertices: [CGPoint]) {
		self.vertices = vertices
	}

	public init(rect: CGRect) {
		self.init(vertices: [
			CGPointMake(rect.origin.x, rect.origin.y),
			CGPointMake(rect.origin.x + rect.size.width, rect.origin.y),
			CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height),
			CGPointMake(rect.origin.x, rect.origin.y + rect.size.height),
		])
	}
}