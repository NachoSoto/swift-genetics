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

	public static func RandomGene() -> Gene {
		return self(color: UIColor.Random(), polygon: Polygon.Random())
	}

	public func mutate() -> Gene {
		return Gene(color: color.mutate(), polygon: polygon.mutate())
	}
}

