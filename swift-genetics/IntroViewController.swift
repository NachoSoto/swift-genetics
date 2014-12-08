//
//  IntroViewController.swift
//  swift-genetics
//
//  Created by Nacho Soto on 12/7/14.
//  Copyright (c) 2014 Nacho Soto. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBAction func onSelectImage(button: UIButton) {
		let picker = UIImagePickerController()
		picker.sourceType = .PhotoLibrary
		picker.allowsEditing = false
		picker.delegate = self

		let popver = UIPopoverController(contentViewController: picker)
		popver.presentPopoverFromRect(button.frame, inView: view, permittedArrowDirections: .Up, animated: false)
	}

	// MARK: UIImagePickerControllerDelegate

	func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		picker.dismissViewControllerAnimated(true) {
			self.imageSelected(image)
		}
	}

	// MARK:

	private func imageSelected(image: UIImage) {
		
	}
}

