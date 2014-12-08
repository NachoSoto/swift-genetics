//
//  UIColor+Extensions.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

extension UIColor {
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		let components = CGColorGetComponents(CGColor)

		return (components[0], components[1], components[2], components[3])
	}
}