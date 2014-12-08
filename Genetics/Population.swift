//
//  Population.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

public struct Population {
	private static var SelectionCutoff: Float { return 0.25 }

	public let individuals: [Individual]
	public let referenceImage: UIImage

	public func iterate() -> Population {
		let size = individuals.count
		let fitnessCalculator = FitnessCalculator()

		var offspring = [Individual]()

		// The number of individuals from the current generation to select for breeding
		let selectCount = Int(floor(Float(size) * Population.SelectionCutoff))
		// The number of individuals to randomly generate
		let generateCount = Int(ceil(1 / Population.SelectionCutoff))

		let sortedIndividuals = sorted(individuals) { $0.fitness > $1.fitness }


		for i in 0..<selectCount {
			for j in 0..<generateCount {
				let randIndividual = randomElementInArray(Array(0..<selectCount), except: i)

				let dna = DNA(mother: sortedIndividuals[i].dna, father: sortedIndividuals[randIndividual].dna)

				offspring.append(Individual(dna: dna, fitness: fitnessCalculator.fitnessForDNA(dna, withReferenceImage: referenceImage)))
			}
		}

		// fittest survives
		offspring.append(sortedIndividuals.first!)

		return Population(individuals: offspring, referenceImage: referenceImage)
	}
}

extension Population {
	public static func PopulationForReferenceImage(image: UIImage, withSize size: Int) -> Population {
		let fitnessCalculator = FitnessCalculator()

		let individuals: [Individual] = map(0..<size) { _ in
			let dna = DNA()

			return Individual(dna: dna, fitness: fitnessCalculator.fitnessForDNA(dna, withReferenceImage: image))
		}

		return Population(individuals: individuals, referenceImage: image)
	}
}