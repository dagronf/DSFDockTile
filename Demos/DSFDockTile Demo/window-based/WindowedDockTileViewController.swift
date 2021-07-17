//
//  WindowedDockTileViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 17/7/21.
//

import Cocoa
import DSFDockTile

class WindowedDockTileViewController: NSViewController {

	override var nibName: NSNib.Name? {
		return NSNib.Name("WindowedDockTileViewController")
	}

	static let DefaultImage = NSImage(named: NSImage.Name("demo-image"))!

	lazy var emptyDockTile: DSFDockTile.AppIconType = {
		DSFDockTile.AppIconType(dockTile: self.view.window!.dockTile)
	}()

	lazy var imageDockTile: DSFDockTile.ConstantImage = {
		DSFDockTile.ConstantImage(WindowedDockTileViewController.DefaultImage, dockTile: self.view.window!.dockTile)
	}()

	override func viewDidLoad() {
		 super.viewDidLoad()
		 // Do view setup here.

		self.animate()
	}

	@objc dynamic var isAnimating: Bool = false

	@IBAction func startAnimating(_ sender: Any) {

		self.view.window?.miniaturize(self)

		isAnimating = true
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
			guard let `self` = self else { return }
			self.imageToggle.toggle()

			if self.imageToggle {
				self.emptyDockTile.display()
			}
			else {
				self.imageDockTile.display()
			}
		})
	}

	@IBAction func stopAnimating(_ sender: Any) {
		self.timer?.invalidate()
		self.timer = nil

		self.emptyDockTile.display()

		isAnimating = false
	}

//	override func viewDidAppear() {
////		if let d = self.view.window?.dockTile {
////			DSFDockTile.setBadgeLabel("123", dockTile: d)
////			DSFDockTile.Image(WindowedDockTileViewController.DefaultImage, dockTile: d)
////		}
//
//		self.animate()
//	}
//
//	override func viewWillDisappear() {
//		self.timer?.invalidate()
//		self.timer = nil
//	}

	var imageToggle: Bool = false
	var timer: Timer?

	func animate() {


	}


}
