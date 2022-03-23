//
//  DSFDockTile+Animation.swift
//  DSFDockTile
//
//  Created by Darren Ford on 17/7/21
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import AppKit
import DSFImageFlipbook

extension DSFDockTile {

	/// A docktile object that handles an animation
	public class Animated: Image {

		/// The flipbook used to handle the animation
		public let flipbook: DSFImageFlipbook

		// Flipbook animation settings
		fileprivate var stopAtEndOfCurrentLoop: Bool = false

		/// Is the animation currently playing?
		@inlinable public var isAnimating: Bool {
			return flipbook.isAnimating()
		}

		/// Create a DockTile object presenting an animation
		/// - Parameters:
		///   - flipbook: The flipbook containing the image to present
		///   - dockTile: The docktile to update
		public init(_ flipbook: DSFImageFlipbook,
						dockTile: NSDockTile? = NSApp?.dockTile) {
			self.flipbook = flipbook
			super.init(dockTile: dockTile)
		}

		/// Create a DockTile object presenting an animation from the raw data
		/// - Parameters:
		///   - flipbook: The image data for the animation (eg. a gif file)
		///   - dockTile: The docktile to update
		public init?(
			animatedImageData: Data,
			dockTile: NSDockTile? = NSApp?.dockTile)
		{
			let fb = DSFImageFlipbook()
			_ = fb.loadFrames(from: animatedImageData)
			guard fb.frameCount > 0 else {
				return nil
			}
			self.flipbook = fb
			super.init(dockTile: dockTile)
		}

		/// Display the first frame of the animation
		public override func display() {
			if let image = flipbook.frame(at: 0)?.image {
				self.display(image)
			}
		}

		/// Start the flipbook animation on the docktile
		/// - Parameter frame: The frame in the flipbook to start animating at
		/// - Parameter speed: The speed to animate the dock tile
		public func startAnimating(atFrame frame: Int = 0, speed: Double = 1) {
			self.stopAtEndOfCurrentLoop = false
			flipbook.start(
				startAtFrame: frame,
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
		public func stopAnimating(stopAtEndOfCurrentLoop: Bool = false) {
			if flipbook.isAnimating() == false ||
					self.stopAtEndOfCurrentLoop
			{
				return
			}

			self.stopAtEndOfCurrentLoop = stopAtEndOfCurrentLoop

			if stopAtEndOfCurrentLoop == false {
				flipbook.stop(reason: .userStopped)
			}
		}

	}
}
