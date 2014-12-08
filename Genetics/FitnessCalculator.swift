//
//  FitnessCalculator.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation
import Surge

public typealias Fitness = Double

public class FitnessCalculator {
	public init() {}

	public func fitnessBetweenImages(imageA: UIImage, _ imageB: UIImage) -> Fitness {
		precondition(imageA.size == imageB.size, "Images must have the same size")
		precondition(imageA.scale == imageB.scale, "Images must have the same scale")

		let imageSize = imageA.size
		let width = Int(imageSize.width)
		let height = Int(imageSize.height)

		var fitness: Fitness = 0

		let imageAData = imageA.imageData()
		let imageBData = imageB.imageData()

		for x in 0..<width {
			for y in 0..<height {
				let point = (x, y)

				let colorA = UIImage.colorAtPoint(point, imageWidth: width, withData: imageAData)
				let colorB = UIImage.colorAtPoint(point, imageWidth: width, withData: imageBData)

				fitness += colorA.distanceToColor(colorB)
			}
		}
		
		return fitness
	}
}

private extension UIImage {
	func imageData() -> UnsafePointer<UInt8> {
		let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))

		return CFDataGetBytePtr(pixelData)
	}

	class func colorAtPoint(point: (x: Int, y: Int), imageWidth: Int, withData data: UnsafePointer<UInt8>) -> UIColor {
		let offset = 4 * ((imageWidth * point.y) + point.x)

		var r = CGFloat(data[offset])
		var g = CGFloat(data[offset + 1])
		var b = CGFloat(data[offset + 2])
		var a = CGFloat(data[offset + 3])

		return UIColor(red: r, green: g, blue: b, alpha: a)
	}
}

private extension UIColor {
	func distanceToColor(color: UIColor) -> Double {
		let componentsA = self.components
		let componentsB = color.components

		let delta = (red: componentsA.red - componentsB.red, green: componentsA.green - componentsB.green, blue: componentsA.blue - componentsB.blue)

		return Double(delta.red * delta.red + delta.green * delta.green + delta.blue * delta.blue)

		// This is orders of magnitud slower than the approach above :(
//		return Array(zip(componentsA, componentsB))
//			.map { Double(pow(($0 - $1), 2)) }
//			.reduce(0, +)
	}
}
