//
//  Gene.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct Gene {
	public let color: UIColor
	public let polygon: Polygon

	public static func RandomGeneForIndex(index: Int, withTotal total: Int) -> Gene {
		let genesPerRow = Int(round(sqrt(Double(total))))
		let row = index / genesPerRow
		let column = index % genesPerRow

		let rectSize: CGFloat = 1.0 / CGFloat(genesPerRow)

		let rect = CGRect(
			x: CGFloat(column) * rectSize,
			y: CGFloat(row) * rectSize,
			width: rectSize,
			height: rectSize
		)

		return self(
			color: UIColor.Random(),
			polygon: Polygon(rect: CGRectInset(rect, -rectSize / 2, -rectSize / 2))
		)
	}

	public func mutate(#color: Bool, polygon: Bool) -> Gene {
		return Gene(
			color: (color) ? self.color.mutate() : self.color,
			polygon: (polygon) ? self.polygon.mutate() : self.polygon
		)
	}
}

