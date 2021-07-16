//
//  AnimatedViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa
import DSFImageFlipbook

class AnimatedViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("AnimatedViewController")
	}

	@objc dynamic var speed: Double = 1.0

	let dockTile: DSFDockTile = {
		let fb = DSFImageFlipbook()
		let da = NSDataAsset(name: NSDataAsset.Name("shark"))!
		_ = fb.loadFrames(from: da.data)
		return DSFDockTile(fb)
	}()

	let charizard: DSFDockTile = {
		let fb = DSFImageFlipbook()
		let da = NSDataAsset(name: NSDataAsset.Name("animated"))!
		_ = fb.loadFrames(from: da.data)
		return DSFDockTile(fb)
	}()

	lazy var selectedDockImage: DSFDockTile = {
		dockTile
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	@objc dynamic var isAnimating: Bool = false

	@IBAction func startAnimating(_ sender: Any) {
		selectedDockImage.startAnimating(speed: self.speed)
		isAnimating = true
	}

	@IBAction func stopAnimating(_ sender: Any) {
		selectedDockImage.stopAnimating()
		isAnimating = false
	}

	@IBAction func stopAnimatingAtEndOfLoop(_ sender: Any) {
		selectedDockImage.flipbook?.animationDidComplete = { [unowned self] _ in
			isAnimating = false
		}
		selectedDockImage.stopAnimating(stopAtEndOfCurrentLoop: true)
	}

	override func viewWillAppear() {
		selectedDockImage.display()
		self.stopAnimating(self)
	}

	override func viewWillDisappear() {
		self.stopAnimating(self)
	}

	@IBAction func imageChanged(_ sender: NSSegmentedControl) {
		switch sender.selectedSegment {
		case 0:
			selectedDockImage = dockTile
		case 1:
			selectedDockImage = charizard
		default:
			fatalError()
		}
		selectedDockImage.display()
	}

	@IBAction func speedDidChange(_ sender: NSSlider) {
		switch Int(sender.doubleValue) {
		case 0: self.speed = 0.125
		case 1: self.speed = 0.25
		case 2: self.speed = 0.5
		case 3: self.speed = 1
		case 4: self.speed = 2
		case 5: self.speed = 3
		case 6: self.speed = 4
		default: fatalError()
		}
	}



}
