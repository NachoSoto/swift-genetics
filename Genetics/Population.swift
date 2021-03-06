//
//  Population.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation
import ReactiveCocoa
import LlamaKit

private let Size: Int = 45

public struct Population {

	private static var Queue: dispatch_queue_t = { return dispatch_queue_create("com.nachosoto.offspring",  DISPATCH_QUEUE_CONCURRENT) }()

	public let individuals: [Individual]
	public let referenceImageData: ImageDataType

	public init(individuals: [Individual], referenceImageData: ImageDataType) {
		assert(individuals.count >= Size, "Invalid population")

		println("Creating population with \(individuals.count) individuals")

		self.individuals = sorted(individuals) { $0.fitness > $1.fitness }
		self.referenceImageData = referenceImageData
	}

	// Inspired on http://chriscummins.cc/s/genetics/#
	public func iterate() -> Population {
		let fitnessCalculator = FitnessCalculator()
		let referenceImage = referenceImageData
		let selectionCutoff = settings.selectionCutoff

		var offspring = [ColdSignal<Individual>]()
		let scheduler = QueueScheduler(Population.Queue)

		if individuals.count > 1 {
			// The number of individuals from the current generation to select for breeding
			let selectCount = max(Int(floor(Float(Size) * selectionCutoff)), 2)
			// The number of individuals to randomly generate
			let generateCount = max(Int(ceil(1.0 / selectionCutoff)), 1)

			for i in 0..<selectCount {
				for j in 0..<generateCount {
					let randIndividualIndex = randomElementInArray(Array(0..<selectCount), except: i)
					let dna = DNA(mother: individuals[i].dna, father: individuals[randIndividualIndex].dna)

					let signal = ColdSignal<Individual> { (sink, _) in
						let individual = Individual(dna: dna, fitness: fitnessCalculator.fitnessForDNA(dna, withReferenceImageData: referenceImage))

						sink.put(.Next(Box(individual)))
						sink.put(.Completed)
					}.evaluateOn(scheduler)

					offspring.append(signal)
				}
			}

			if settings.fittestSurvives {
				offspring.append(ColdSignal.single(individuals.first!))
			}
		} else {
			fatalError("Asexual reproduction not supported")
		}

		return Population(individuals: offspring.map { $0.single().value()! }, referenceImageData: referenceImage)
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