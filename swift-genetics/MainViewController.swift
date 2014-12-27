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

	private var decimalNumberFormatter: NSNumberFormatter = {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.maximumFractionDigits = 3

		return formatter
	}()

	private var iterations: Int = 0

	private var population: Population? {
		didSet {
			if let population = population {
				let size = imageView.bounds.size
				let scale = view.contentScaleFactor

				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
					let image = population.fittestIndividual.dna.imageWithSize(size, scale: scale)

					dispatch_sync(dispatch_get_main_queue()) {
						self.iterations += 1

						self.imageView.image = image
						self.currentFitnessLabel.text = "Fitness:\n\(self.decimalNumberFormatter.stringFromNumber(population.fittestIndividual.fitness)!)"
						self.iterationsLabel.text = "Iterations: \(self.iterations)"
					}
				}
			}
		}
	}

	
	@IBOutlet private var mutationChanceLabel: UILabel!
	@IBOutlet private var mutationChanceSlider: UISlider!
	@IBOutlet private var mutationAmountLabel: UILabel!
	@IBOutlet private var selectionCutoffLabel: UILabel!
	@IBOutlet private var selectionCutoffSlider: UISlider!
	@IBOutlet private var mutationAmountSlider: UISlider!
	@IBOutlet private var fittestSurvivesSwitch: UISwitch!

	@IBOutlet private var iterationsLabel: UILabel!
	@IBOutlet private var currentFitnessLabel: UILabel!
	@IBOutlet private var imageView: UIImageView!

	var referenceImage: UIImage!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.interactivePopGestureRecognizer.enabled = false

		updateSettings()
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		assert(referenceImage != nil, "Reference image was not set")
		startWithPopulation(Population.PopulationForReferenceImage(referenceImage))
	}

	// MARK: Iteration

	func startWithPopulation(var population: Population) {
		self.population = population

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
			while self != nil {
				autoreleasepool {
					population = self!.iterate(population)
				}
			}
		}
	}

	private func iterate(population: Population) -> Population {
		let newPopulation = population.iterate()

		dispatch_async(dispatch_get_main_queue()) { [weak self] in
			self?.population = newPopulation
			return
		}

		return newPopulation
	}

	// MARK: Events

	@IBAction func mutationChanceChanged(sender: UISlider) {
		updateSettings()
	}

	@IBAction func mutationAmountChanged(sender: UISlider) {
		updateSettings()
	}

	@IBAction func selectionCutoffChanged(sender: UISlider) {
		updateSettings()
	}

	private func updateSettings() {
		println("Updating settings")

		Genetics.settings.mutationChance = mutationChanceSlider.value
		Genetics.settings.mutationAmount = mutationAmountSlider.value
		Genetics.settings.selectionCutoff = selectionCutoffSlider.value
		Genetics.settings.fittestSurvives = fittestSurvivesSwitch.enabled

		mutationChanceLabel.text = "Mutation chance: \(self.decimalNumberFormatter.stringFromNumber(Genetics.settings.mutationChance)!)"
		mutationAmountLabel.text = "Mutation amount: \(self.decimalNumberFormatter.stringFromNumber(Genetics.settings.mutationAmount)!)"
		selectionCutoffLabel.text = "Selection cutoff: \(self.decimalNumberFormatter.stringFromNumber(Genetics.settings.selectionCutoff)!)"
	}
}