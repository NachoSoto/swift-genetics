//
//  FitnessCalculator.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public typealias Fitness = Double

public final class FitnessCalculator {
	public init() {}

	public func fitnessForDNA(dna: DNA, withReferenceImageData referenceImageData: ImageDataType) -> Fitness {
		return fitnessBetweenImages(referenceImageData, ImagePixels.ImageForDNA(dna, width: referenceImageData.width, height: referenceImageData.height))
	}

	private func fitnessBetweenImages(imageA: ImageDataType, _ imageB: ImageDataType) -> Fitness {
		precondition(imageA.pixels.count == imageB.pixels.count)

		var fitness: Fitness = 0

		for (pixelA, pixelB) in Zip2(imageA.pixels, imageB.pixels) {
			fitness += distance(pixelA, pixelB)
		}

		return 1.0 - fitness
	}
}

private func distance(a: RGBAPixel, b: RGBAPixel) -> Fitness {
	let delta = (red: Fitness(a.red) - Fitness(b.red), green: Fitness(a.green) - Fitness(b.green), blue: Fitness(a.blue) - Fitness(b.blue))

	return delta.red * delta.red + delta.green * delta.green + delta.blue * delta.blue
}

