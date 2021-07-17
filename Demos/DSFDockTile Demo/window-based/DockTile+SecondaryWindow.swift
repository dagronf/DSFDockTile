//
//  DockTile+SecondaryWindow.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 17/7/21.
//

import AppKit

var windowedDockTile: NSWindow?
var windowedDockTileViewController: WindowedDockTileViewController?

func OpenNewSubWindow() {

	windowedDockTileViewController = WindowedDockTileViewController()

	let w = NSWindow(contentViewController: windowedDockTileViewController!)
	w.title = "Secondary Window DockTile Demo"
	w.makeKeyAndOrderFront(nil)
	w.resizeIncrements

	windowedDockTile = w
}
