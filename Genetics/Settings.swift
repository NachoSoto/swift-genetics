//
//  Settings.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/25/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import Foundation

// This isn't a great pattern, but it's the easiest for this demo app.
public var settings = Settings()

public struct Settings {
	public var mutationAmount: Float = 0.01
	public var mutationChance: Float = 0.08
	public var fittestSurvives: Bool = false
}