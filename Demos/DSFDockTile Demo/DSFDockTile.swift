//
//  DSFDockTile.swift
//  DockTile Stuff
//
//  Created by Darren Ford on 16/7/21.
//

import AppKit
import DSFImageFlipbook

public class DSFDockTile {

	// The docktile to update. By default, this is the App Icon
	private weak var dockTile: NSDockTile?

	// Image settings
	private let image: NSImage?

	// View settings
	private weak var viewController: NSViewController?

	// Flipbook animation settings
	let flipbook: DSFImageFlipbook?
	private var stopAtEndOfCurrentLoop: Bool = false

	// A lazy imageview to use when displaying images
	private let _imageDisplayView: NSImageView = {
		let v = NSImageView()
		v.wantsLayer = true
		v.imageScaling = .scaleProportionallyUpOrDown
		return v
	}()

	/// Set the dock badge
	public var badge: String? {
		didSet {
			self.dockTile?.badgeLabel = self.badge
		}
	}

	/// A docktile that represents the current application's icon
	public static let AppIcon = DSFDockTile()

	public init(dockTile: NSDockTile = NSApp.dockTile) {
		self.dockTile = dockTile
		self.image = nil
		self.viewController = nil
		self.flipbook = nil
	}

	/// Create a DockTile object containing an image
	/// - Parameters:
	///   - image: The image to display on the docktile
	///   - dockTile: The docktile to update
	public init(_ image: NSImage,
	            dockTile: NSDockTile = NSApp.dockTile)
	{
		self.dockTile = dockTile
		self.image = image
		self.viewController = nil
		self.flipbook = nil
	}

	/// Create a DockTile object presenting a view that's managed by an NSViewController
	/// - Parameters:
	///   - viewController: The view controller managing the view to be presented
	///   - dockTile: The docktile to update
	public init(_ viewController: NSViewController,
	            dockTile: NSDockTile = NSApp.dockTile)
	{
		self.dockTile = dockTile
		self.viewController = viewController
		self.image = nil
		self.flipbook = nil
	}

	/// Create a DockTile object presenting an animation
	/// - Parameters:
	///   - flipbook: The flipbook containing the image to present
	///   - dockTile: The docktile to update
	public init(_ flipbook: DSFImageFlipbook,
	            dockTile: NSDockTile = NSApp.dockTile)
	{
		self.dockTile = dockTile
		self.flipbook = flipbook
		self.image = nil
		self.viewController = nil
	}

	/// Update the dock image
	public func display() {
		if let _ = self.image {
			self.presentImage()
		}
		else if let _ = self.viewController {
			presentView()
		}
		else if let _ = self.flipbook {
			self.presentFlipbook()
		}
		else {
			self.dockTile?.contentView = nil
		}
	}
}

// MARK: - Images

public extension DSFDockTile {

	/// Set image as docktile
	/// - Parameter cgImage: The image to display in the docktile
	@inlinable func display(_ cgImage: CGImage) {
		self.display(NSImage(cgImage: cgImage, size: .zero))
	}

	/// Set image as docktile
	/// - Parameter nsImage: The image to display in the docktile
	func display(_ nsImage: NSImage) {
		precondition(Thread.isMainThread)

		guard let tile = self.dockTile else {
			return
		}

		let imageView = self._imageDisplayView

		// Get the view to draw the image
		if tile.contentView !== imageView {
			tile.contentView = imageView
		}

		// Update the image view with the new image
		imageView.image = nsImage

		// And update the docktile display
		tile.display()

		// Make sure the badge is updated to reflect the stored badge
		tile.badgeLabel = self.badge
	}

	// Present the stored image
	private func presentImage() {
		precondition(Thread.isMainThread)

		guard let tile = self.dockTile else {
			return
		}

		let imageView = self._imageDisplayView

		// Get the view to draw the image
		if tile.contentView !== self._imageDisplayView {
			tile.contentView = imageView
		}

		// Update the image view with the new image
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		imageView.layer?.contents = self.image
		CATransaction.commit()

		// And update the docktile display
		tile.display()

		// Make sure the badge is updated to reflect the stored badge
		tile.badgeLabel = self.badge
	}
}

// MARK: - View/View Controllre

private extension DSFDockTile {
	// Set view as docktile
	func presentView() {
		precondition(Thread.isMainThread)

		guard let tile = self.dockTile,
				let vc = self.viewController else {
			return
		}

		// Make sure the docktile is showing our view
		if tile.contentView !== vc.view {
			tile.contentView = vc.view
		}

		// And update the docktile display
		tile.display()

		// Make sure the badge is updated to reflect the stored badge
		tile.badgeLabel = self.badge
	}
}

public extension DSFDockTile {
	private func presentFlipbook() {
		guard let f = flipbook else { fatalError() }
		self.display(f.frame(at: 0)!.image)
	}

	/// Start the flipbook animation on the docktile
	/// - Parameter frame: The frame in the flipbook to start animating at
	/// - Parameter speed: The speed to animate the dock tile
	func startAnimating(atFrame frame: Int = 0, speed: Double = 1) {
		self.stopAtEndOfCurrentLoop = false
		guard let f = flipbook else { fatalError() }
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
		guard let f = flipbook else { fatalError() }

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
