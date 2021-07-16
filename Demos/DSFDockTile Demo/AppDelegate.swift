//
//  AppDelegate.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet var window: NSWindow!
	@IBOutlet weak var tabView: NSTabView!

	let infoVC = NSInfoViewController()
	lazy var infoTC: NSTabViewItem = { NSTabViewItem(viewController: infoVC) }()
	let imageVC = ImageViewController()
	lazy var imageTC: NSTabViewItem = { NSTabViewItem(viewController: imageVC) }()
	let animatedVC = AnimatedViewController()
	lazy var animatedTC: NSTabViewItem = { NSTabViewItem(viewController: animatedVC) }()
	let xibVC = XIBViewController()
	lazy var xibTC: NSTabViewItem = { NSTabViewItem(viewController: xibVC) }()


	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application

		tabView.addTabViewItem(infoTC)
		tabView.addTabViewItem(imageTC)
		tabView.addTabViewItem(animatedTC)
		tabView.addTabViewItem(xibTC)

		tabView.selectTabViewItem(infoTC)

	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}

	@IBAction func tabChanged(_ sender: NSToolbarItem) {
		switch sender.tag {
		case -1: tabView.selectTabViewItem(infoTC)
		case 0: tabView.selectTabViewItem(imageTC)
		case 1: tabView.selectTabViewItem(animatedTC)
		case 2: tabView.selectTabViewItem(xibTC)
		default: fatalError()
		}
	}

}

