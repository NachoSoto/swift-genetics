//
//  FitnessCalculator.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation
import UIKit

public typealias Fitness = Double

public class FitnessCalculator {
	public init() {}

	public func fitnessForDNA(dna: DNA, withReferenceImage image: UIImage) -> Fitness {
		return fitnessBetweenImages(image, dna.drawWithSize(image.size, scale: image.scale))
	}

	private func fitnessBetweenImages(imageA: UIImage, _ imageB: UIImage) -> Fitness {
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

				fitness += distanceBetweenColors(colorA, colorB) as Fitness
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
}

private typealias ColorComponents = (red: CGFloat, blue: CGFloat, green: CGFloat)

private func distanceBetweenColors(colorA: ColorComponents, colorB: ColorComponents) -> Double {
	let delta = (red: colorA.red - colorB.red, green: colorA.green - colorB.green, blue: colorA.blue - colorB.blue)

	return Double(delta.red * delta.red + delta.green * delta.green + delta.blue * delta.blue)
}

private extension UIImage {
	class func colorAtPoint(point: (x: Int, y: Int), imageWidth: Int, withData data: UnsafePointer<UInt8>) -> ColorComponents {
		let offset = 4 * ((imageWidth * point.y) + point.x)

		var r = CGFloat(data[offset])
		var g = CGFloat(data[offset + 1])
		var b = CGFloat(data[offset + 2])

		return (red: r, green: g, blue: b)
	}
}