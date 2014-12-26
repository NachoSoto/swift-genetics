//
//  DNA.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct DNA {
	private static var Length: Int { return 350 }

	public let genes: [Gene]

	public init() {
		genes = map(0..<DNA.Length) { Gene.RandomGeneForIndex($0, withTotal: DNA.Length) }
	}

	public init(mother: DNA, father: DNA) {
		precondition(mother.genes.count == father.genes.count, "Invalid parents")

		let chance = settings.mutationChance

		genes = map(Zip2(mother.genes, father.genes)) { (motherGene, fatherGene) in
			let inheritedGene = (Bool.Random()) ? motherGene : fatherGene

			return inheritedGene.mutate(
				color: roll(chance),
				polygon: roll(chance)
			)
		}
	}
}