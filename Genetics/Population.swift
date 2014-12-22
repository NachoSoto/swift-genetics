//
//  Population.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

private let Size: Int = 30

public struct Population {

	private static var SelectionCutoff: Float { return 0.5 }

	public let individuals: [Individual]
	public let referenceImageData: ImageDataType

	public init(individuals: [Individual], referenceImageData: ImageDataType) {
		assert(individuals.count >= Size, "Invalid population")

		self.individuals = sorted(individuals) { $0.fitness > $1.fitness }
		self.referenceImageData = referenceImageData
	}

	// Inspired on http://chriscummins.cc/s/genetics/#
	public func iterate() -> Population {
		let fitnessCalculator = FitnessCalculator()

		var offspring = [Individual]()

		if individuals.count > 1 {
			// The number of individuals from the current generation to select for breeding
			let selectCount = max(Int(floor(Float(Size) * Population.SelectionCutoff)), 2)
			// The number of individuals to randomly generate
			let generateCount = max(Int(ceil(1.0 / Population.SelectionCutoff)), 1)

			for i in 0..<selectCount {
				for j in 0..<generateCount {
					let randIndividual = randomElementInArray(Array(0..<selectCount), except: i)

					let dna = DNA(mother: individuals[i].dna, father: individuals[randIndividual].dna)

					offspring.append(Individual(dna: dna, fitness: fitnessCalculator.fitnessForDNA(dna, withReferenceImageData: referenceImageData)))
				}
			}

			// fittest survives
			offspring.append(individuals.first!)
		} else {
			// Asexual reproduction
			let parent = individuals.first!
			let childDNA = DNA(mother: parent.dna, father: parent.dna);

			let child = Individual(dna: childDNA, fitness: fitnessCalculator.fitnessForDNA(childDNA, withReferenceImageData: referenceImageData))

			if (child.fitness < parent.fitness) {
				offspring = [child]
			} else {
				offspring = [parent]
			}
		}

		return Population(individuals: offspring, referenceImageData: referenceImageData)
	}

	public var fittestIndividual: Individual {
		return individuals.first!
	}
}

extension Population {
	public static func PopulationForReferenceImage(image: UIImage) -> Population {
		let fitnessCalculator = FitnessCalculator()

		let imageData = ImagePixels.ImagePixelsWithImage(image.CGImage)

		let individuals: [Individual] = map(0..<Size) { _ in
			let dna = DNA()

			return Individual(dna: dna, fitness: fitnessCalculator.fitnessForDNA(dna, withReferenceImageData: imageData))
		}

		return Population(individuals: individuals, referenceImageData: imageData)
	}
}