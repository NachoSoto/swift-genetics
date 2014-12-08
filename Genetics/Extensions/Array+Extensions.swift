//
//  Array+Extensions.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

// Given two sequences, return a sequence of 2-tuples (pairs)
public func zip<A: SequenceType, B: SequenceType>(a: A, b: B) -> ZipSequence<A, B> {
	return ZipSequence(a, b)
}

// Lazy sequence of tuples created from values from two other sequences
public struct ZipSequence<A: SequenceType, B: SequenceType>: SequenceType {
	private var a: A
	private var b: B

	public init(_ a: A, _ b: B) {
		self.a = a
		self.b = b
	}

	public func generate() -> ZipGenerator<A.Generator, B.Generator> {
		return ZipGenerator(a.generate(), b.generate())
	}
}

// Generator that creates tuples of values from two other generators
public struct ZipGenerator<A: GeneratorType, B: GeneratorType>: GeneratorType {
	private var a: A
	private var b: B

	public init(_ a: A, _ b: B) {
		self.a = a
		self.b = b
	}

	mutating public func next() -> (A.Element, B.Element)? {
		switch (a.next(), b.next()) {
		case let (.Some(aValue), .Some(bValue)):
			return (aValue, bValue)
		default:
			return nil
		}
	}
}