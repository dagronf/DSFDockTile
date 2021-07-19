//
//  ContentView.swift
//  DSFDockTile Plugin Demo
//
//  Created by Darren Ford on 19/7/21.
//

import SwiftUI

struct ContentView: View {

	@Environment(\.colorScheme) var scheme

	var body: some View {
		VStack(spacing: 16) {
			LightDarkImage()
				.frame(width: 196, height: 196)

			Text("NSDockTile Plugin Demo").font(.title)
				.frame(alignment: .center)

			VStack(alignment: .leading) {
				Text("This demo uses a NSDockTile plugin to display its dock content")
				Text("Change the appearance to/from dark mode to see the dock icon change")
				Text("Note this change occurs even if the app isn't running (but it has been added to the dock)")
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
