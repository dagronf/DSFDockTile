//
//  WindowedDockTileViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 17/7/21.
//

import Cocoa
import DSFDockTile
import DSFImageFlipbook

class WindowedDockTileViewController: NSViewController {

	override var nibName: NSNib.Name? {
		return NSNib.Name("WindowedDockTileViewController")
	}

	lazy var animatedDockTile: DSFDockTile.Animated = {
		let fb = DSFImageFlipbook()
		let da = NSDataAsset(name: NSDataAsset.Name("marble"))!
		_ = fb.loadFrames(from: da.data)

		/// Attach to the window's docktile
		return DSFDockTile.Animated(fb, dockTile: self.view.window!.dockTile)
	}()

	override func viewDidLoad() {
		 super.viewDidLoad()
		 // Do view setup here.
	}

	@objc dynamic var isAnimating: Bool = false

	@IBAction func startAnimating(_ sender: Any) {
		guard isAnimating == false else { return }
		isAnimating = true
		self.view.window?.miniaturize(self)
		self.animatedDockTile.startAnimating()
	}

	@IBAction func stopAnimating(_ sender: Any) {
		isAnimating = false
		self.animatedDockTile.stopAnimating()
	}
}
