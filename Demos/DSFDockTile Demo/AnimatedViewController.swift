//
//  AnimatedViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import AppKit

import DSFDockTile
import DSFImageFlipbook

class AnimatedViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("AnimatedViewController")
	}

	@objc dynamic var speed: Double = 1.0

	let dockTile: DSFDockTile.Animated = {
		let fb = DSFImageFlipbook()
		let da = NSDataAsset(name: NSDataAsset.Name("animate-shark"))!
		_ = fb.loadFrames(from: da.data)
		return DSFDockTile.Animated(fb)
	}()

	let charizard: DSFDockTile.Animated = {
		let fb = DSFImageFlipbook()
		let da = NSDataAsset(name: NSDataAsset.Name("animate-charizard"))!
		_ = fb.loadFrames(from: da.data)
		return DSFDockTile.Animated(fb)
	}()

	lazy var selectedDockImage: DSFDockTile.Animated = {
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
		selectedDockImage.flipbook.animationDidComplete = { [unowned self] _ in
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

extension AnimatedViewController {
	@IBAction func selectNewGIF(_ sender: Any) {
		let myOpen = NSOpenPanel()
		myOpen.allowedFileTypes = ["com.compuserve.gif"]
		myOpen.canChooseFiles = true
		myOpen.allowsMultipleSelection = false
		myOpen.beginSheetModal(for: self.view.window!) { [weak self] response in
			if response == .OK {
				DispatchQueue.main.async { [weak self] in
					self?.imageChanged(from: myOpen.url!)
				}
			}
		}
	}

	func imageChanged(from url: URL) {
		guard let image = NSImage(contentsOf: url) else { return }
		let fb = DSFImageFlipbook()
		_ = fb.loadFrames(from: image)
		if fb.frameCount > 0 {
			selectedDockImage = DSFDockTile.Animated(fb)
			selectedDockImage.display()
		}
	}
}
