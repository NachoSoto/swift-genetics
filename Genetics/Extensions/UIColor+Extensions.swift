//
//  UIColor+Extensions.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension UIColor {
	var components: [CGFloat] {
		let components = CGColorGetComponents(CGColor)
		let componentIndexes = 0..<Int(CGColorGetNumberOfComponents(CGColor))

		return map(componentIndexes) { components[$0] }
	}
	
}