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

	public func fitnessForDNA(dna: DNA, withReferenceImageData referenceImageData: ImageDataType) -> Fitness {
		return fitnessBetweenImages(referenceImageData, ImagePixels.ImageForDNA(dna, width: referenceImageData.width, height: referenceImageData.height))
	}

	private func fitnessBetweenImages(imageA: ImageDataType, _ imageB: ImageDataType) -> Fitness {
		precondition(imageA.pixels.count == imageB.pixels.count)

		var fitness: Fitness = 0

		for x in 0..<imageA.pixels.count {
			fitness += distance(imageA.pixels[x], imageB.pixels[x]) as Fitness
		}

		return fitness
	}
}
private func distance(a: RGBPixel, b: RGBPixel) -> Double {
	let delta = (red: a.red - b.red, green: a.green - b.green, blue: a.blue - b.blue)

	return Double(delta.red * delta.red + delta.green * delta.green + delta.blue * delta.blue)
}

