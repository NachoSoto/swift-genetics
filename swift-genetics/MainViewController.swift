//
//  MainViewController.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import UIKit
import Genetics

class MainViewController: UIViewController {
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	private var population: Population? {
		didSet {
			if let population = population {
				let size = imageView.bounds.size
				let scale = view.contentScaleFactor

				println("Fittest: \(population.fittestIndividual.fitness)")

				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
					let image = population.fittestIndividual.dna.imageWithSize(size, scale: scale)

					dispatch_sync(dispatch_get_main_queue()) {
						self.imageView.image = image
					}
				}
			}
		}
	}

	var referenceImage: UIImage!

	@IBOutlet private var imageView: UIImageView!

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		assert(referenceImage != nil, "Reference image was not set")

		startWithPopulation(Population.PopulationForReferenceImage(referenceImage))
	}

	func startWithPopulation(population: Population) {
		self.population = population

		iterate()
	}

	private func iterate() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
			let newPopulation = self.population!.iterate()

			dispatch_async(dispatch_get_main_queue()) {
				self.population = newPopulation

				self.iterate()
			}
		}
	}
}