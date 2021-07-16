//
//  ImageViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa

class ImageViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("ImageViewController")
	}

	let dockImage = DSFDockTile()

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
		dockImage.display(image)
	}

	override func viewWillDisappear() {

	}
    
}
