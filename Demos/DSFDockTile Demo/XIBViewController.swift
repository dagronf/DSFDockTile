//
//  XIBViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa

class XIBViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("XIBViewController")
	}

	let dockViewController = DockViewController()
	lazy var updateDockTile: DSFDockTile = {
		dockViewController.loadView()
		return DSFDockTile(dockViewController)
	}()

	@IBOutlet weak var slider: NSSlider!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

	override func viewWillAppear() {
		self.updateDockTile.display()
	}
    
	@IBAction func sliderDidUpdate(_ sender: NSSlider) {
		let value = sender.doubleValue
		dockViewController.value = value

		self.updateDockTile.display()
	}

	@IBAction func colorDidUpdate(_ sender: NSColorWell) {
		dockViewController.gradientArcView.strokeColor = sender.color
		self.updateDockTile.display()
	}

}
