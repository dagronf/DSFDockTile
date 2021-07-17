//
//  XIBViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import AppKit

import DSFDockTile

class XIBViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("XIBViewController")
	}

	/// The view controller to display on the docktile
	let dockViewController = DockViewController()

	/// The docktile instance handling the docktile
	lazy var updateDockTile: DSFDockTile.View = {
		dockViewController.loadView()
		return DSFDockTile.View(dockViewController)
	}()

	@IBOutlet var slider: NSSlider!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	override func viewWillAppear() {
		self.updateDockTile.display()
	}

	@IBAction func sliderDidUpdate(_ sender: NSSlider) {
		let value = sender.doubleValue

		// Change the value being displayed on the docktile
		self.dockViewController.value = value

		// NSDockTile does not update automatically so need to tell it when changes are made
		self.updateDockTile.display()
	}

	@IBAction func colorDidUpdate(_ sender: NSColorWell) {
		// Change the color of the gradient arc
		self.dockViewController.gradientArcView.strokeColor = sender.color

		// NSDockTile does not update automatically so need to tell it when changes are made
		self.updateDockTile.display()
	}
}
