//
//  ImageData.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/21/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

// Some ideas taken from https://github.com/indragiek/DominantColor

public protocol ImageDataType {
	var width: UInt { get}
	var height: UInt { get }

	var pixels: [RGBAPixel] { get }
}

public struct RGBAPixel {
	public let red: UInt8
	public let blue: UInt8
	public let green: UInt8
	public let alpha: UInt8
}

internal struct ImagePixels: ImageDataType {
	let pixels: [RGBAPixel]

	let width: UInt
	let height: UInt
}

// MARK:

private func scaledDimensionsForPixelLimit(limit: UInt, #width: UInt, #height: UInt) -> (width: UInt, height: UInt) {
	if (width * height > limit) {
		let ratio = Float(width) / Float(height)
		let maxWidth = sqrtf(ratio * Float(limit))

		return (UInt(maxWidth), UInt(Float(limit) / maxWidth))
	}

	return (width: width, height: height)
}

extension ImagePixels {
	internal static func ImagePixelsWithImage(image: CGImageRef) -> ImagePixels {
		let PixelLimit: UInt = 10000

		let (width, height) = scaledDimensionsForPixelLimit(
			PixelLimit,
			width: CGImageGetWidth(image),
			height: CGImageGetHeight(image)
		)

		return CreateImageWithWidth(width, height: height) { context in
			CGContextTranslateCTM(context, 0, CGFloat(height));
			CGContextScaleCTM(context, 1.0, -1.0);

			CGContextDrawImage(context, CGRect(x: 0, y: 0, width: Int(width), height: Int(height)), image)

			CGContextScaleCTM(context, 1.0, -1.0);
			CGContextTranslateCTM(context, 0, -CGFloat(height));
		}
	}

	internal static func ImageForDNA(dna: DNA, width: UInt, height: UInt) -> ImagePixels {
		return CreateImageWithWidth(width, height: height) {
			dna.drawWithSize(CGSizeMake(CGFloat(width), CGFloat(height)), inContext: $0)
		}
	}

	private static func CreateImageWithWidth(width: UInt, height: UInt, drawing: (context: CGContextRef) -> ())-> ImagePixels {
		let context = CGBitmapContextCreate(
			nil,
			width,
			height,
			8,          // bits per component
			width * 4,  // bytes per row
			CGColorSpaceCreateDeviceRGB(),
			CGBitmapInfo(CGImageAlphaInfo.NoneSkipLast.rawValue)
		)

		drawing(context: context)

		var pixels = [RGBAPixel]()
		pixels.reserveCapacity(Int(height * width))

		let data = unsafeBitCast(CGBitmapContextGetData(context), UnsafeMutablePointer<RGBAPixel>.self)

		for y in 0..<height {
			for x in 0..<width {
				pixels.append(data[Int(x + y * width)])
			}
		}

		return ImagePixels(pixels: pixels, width: width, height: height)
	}
}