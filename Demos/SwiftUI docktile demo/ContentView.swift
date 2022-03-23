//
//  ContentView.swift
//  SwiftUI docktile demo
//
//  Created by Darren Ford on 22/3/2022.
//

import SwiftUI
import Combine
import DSFDockTile


struct ContentView: View {

	@Binding var isAnimating: Bool

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Example SwiftUI DockTile View demo.").font(.title)
			Text("Try minimising this window to see a window docktile updating.")
			Toggle("Animate window dock tile", isOn: $isAnimating)
		}
		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(isAnimating: .constant(false))
	}
}
