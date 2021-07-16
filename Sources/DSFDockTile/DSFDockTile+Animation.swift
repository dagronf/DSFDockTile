//
//  DSFDockTile+Animation.swift
//
//  Created by Darren Ford on 16/7/21.
//

import AppKit
import DSFImageFlipbook

extension DSFDockTile {

	/// Create a DockTile object presenting an animation
	/// - Parameters:
	///   - flipbook: The flipbook containing the image to present
	///   - dockTile: The docktile to update
	public convenience init(_ flipbook: DSFImageFlipbook,
					dockTile: NSDockTile = NSApp.dockTile)
	{
		self.init(image: nil, viewController: nil, flipbook: flipbook, dockTile: dockTile)
	}
}

public extension DSFDockTile {
	internal func presentFlipbook() {
		guard let f = flipbook as? DSFImageFlipbook else { fatalError() }
		self.display(f.frame(at: 0)!.image)
	}

	/// Start the flipbook animation on the docktile
	/// - Parameter frame: The frame in the flipbook to start animating at
	/// - Parameter speed: The speed to animate the dock tile
	func startAnimating(atFrame frame: Int = 0, speed: Double = 1) {
		self.stopAtEndOfCurrentLoop = false
		guard let f = flipbook as? DSFImageFlipbook else { fatalError() }
		f.start(startAtFrame: frame,
				  speed: speed) { [weak self] frame, currentFrame, count, stop in

			guard let `self` = self else { return }

			self.display(frame.image)

			if self.stopAtEndOfCurrentLoop, currentFrame == (count - 1) {
				stop = true
			}
		}
	}

	/// Stop the current docktile animation
	/// - Parameter stopAtEndOfCurrentLoop: If true, stops the animation at the end of the current animation loop
	func stopAnimating(stopAtEndOfCurrentLoop: Bool = false) {
		guard let f = flipbook as? DSFImageFlipbook else { fatalError() }

		if f.isAnimating() == false ||
			self.stopAtEndOfCurrentLoop
		{
			return
		}

		self.stopAtEndOfCurrentLoop = stopAtEndOfCurrentLoop

		if stopAtEndOfCurrentLoop == false {
			f.stop(reason: .userStopped)
		}
	}
}
