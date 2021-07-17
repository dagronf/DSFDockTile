//
//  ImageViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa
import DSFDockTile

class ImageViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("ImageViewController")
	}

	let dockImage = DSFDockTile.Image()

	static let DefaultImage = NSImage(named: NSImage.Name("baby-shark"))!
	@objc dynamic var image: NSImage = ImageViewController.DefaultImage {
		didSet {
			dockImage.display(image)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	override func viewDidAppear() {
		self.dockImage.display(self.image)
	}

	override func viewWillDisappear() {}
}
