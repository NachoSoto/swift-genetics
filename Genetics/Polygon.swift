//
//  Polygon.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct Polygon {
	private static var VerticeCount: Int { return 3 }

	public let vertices: [CGPoint]

	static func Random() -> Polygon {
		return self(vertices: map(0..<VerticeCount) { _ in CGPoint.Random() })
	}
}