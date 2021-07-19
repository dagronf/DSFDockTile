//
//  DockTilePlugin.swift
//  DockTilePluginTest
//
//  Created by Darren Ford on 25/3/21.
//

import AppKit
import Combine
import os

import DSFDockTile

class DockTilePlugin: NSObject, NSDockTilePlugIn {

	// MARK: - Bundle loading

	private static func LoadImage(named name: String) -> NSImage {
		let bundle = Bundle(for: DockTilePlugin.self)
		let path = bundle.path(forResource: name, ofType: "png")!
		return NSImage(byReferencingFile: path)!
	}

	// MARK: - Images

	private lazy var lightImage: NSImage = {
		return Self.LoadImage(named: "light")
	}()

	private lazy var darkImage: NSImage = {
		return Self.LoadImage(named: "dark")
	}()

	// MARK: - Dock icon
	private var appIcon: DSFDockTile.Image? = nil

	weak var dockTile: NSDockTile? = nil {
		didSet {
			if let d = self.dockTile {
				appIcon = DSFDockTile.Image(dockTile: d)
			}
			else {
				appIcon = nil
			}
		}
	}

	// MARK: - Combine

	// publisher cancellable for theme changes
	private var cancellable: AnyCancellable? = nil

	// MARK: - Plugin callbacks

	/// Invoked when the plug-in is first loaded and when the application is removed from the Dock.
	func setDockTile(_ dockTile: NSDockTile?) {
		guard let dockTile = dockTile else { return }
		self.dockTile = dockTile

		self.updateDockTile()

		self.cancellable = NSApp.publisher(for: \.effectiveAppearance)
			.removeDuplicates()
			.sink { [weak self] appearance in
				self?.updateDockTile(appearance: appearance)
			}
	}
}

extension DockTilePlugin {
	private func updateDockTile(appearance: NSAppearance = NSApp.effectiveAppearance) {
		let isLight = appearance.bestMatch(from: [.aqua, .darkAqua]) == .aqua
		if isLight {
			appIcon?.display(self.lightImage)
		}
		else {
			appIcon?.display(self.darkImage)
		}
	}
}
