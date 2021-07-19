//
//  DSFDockTile_Plugin_DemoApp.swift
//  DSFDockTile Plugin Demo
//
//  Created by Darren Ford on 19/7/21.
//

import SwiftUI

@main
struct DSFDockTile_Plugin_DemoApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
					hideZoomButton()
				})
				.navigationTitle("NSDockTilePlugin Demo")
		}
	}


	func hideZoomButton() {
		if let window = NSApplication.shared.windows.filter({ $0.title == "NSDockTilePlugin Demo" }).first {
			window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
			window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
		}
	}

}
