//
//  DNA.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct DNA {
	private static var Length: Int = 120
	private static var MutationChange: Float = 0.025

	public let genes: [Gene]

	public init() {
		genes = map(0..<DNA.Length) { _ in Gene.RandomGene() }
	}

	public init(mother: DNA, father: DNA) {
		precondition(mother.genes.count == father.genes.count, "Invalid parents")

		genes = map(zip(mother.genes, father.genes)) { (motherGene, fatherGene) in
			let inheritedGene = (Bool.Random()) ? motherGene : fatherGene
			let shouldMutateGene = roll(DNA.MutationChange)

			return (shouldMutateGene) ? inheritedGene.mutate() : inheritedGene
		}
	}
}