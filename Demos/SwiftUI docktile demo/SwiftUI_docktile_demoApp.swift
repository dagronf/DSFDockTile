//
//  SwiftUI_docktile_demoApp.swift
//  SwiftUI docktile demo
//
//  Created by Darren Ford on 22/3/2022.
//

import DSFDockTile
import SwiftUI

let animatedDockTile: DSFDockTile.Animated = {
	let da = NSDataAsset(name: NSDataAsset.Name("marble"))!.data
	return DSFDockTile.Animated(animatedImageData: da)!
}()

@main
struct SwiftUI_docktile_demoApp: App {
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State var count = 0

	@State var animating: Bool = false

	var body: some Scene {
		WindowGroup {
			VStack {
				ContentView(isAnimating: $animating)
					.onReceive(timer) { input in
						count += 1
					}
				// The docktile for the application
				DockTile(
					label: "\(count)",
					content: DockTileContentView(percent: count % 100)
				)

				// The docktile for the _window_ containing this view
				DockTile(
					.window,
					animation: animatedDockTile,
					isAnimating: animating)
			}
		}
	}
}
