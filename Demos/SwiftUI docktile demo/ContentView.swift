//
//  ContentView.swift
//  SwiftUI docktile demo
//
//  Created by Darren Ford on 22/3/2022.
//

import SwiftUI
import Combine

struct ContentView: View {

	var body: some View {
		HStack {
			VStack {
				Text("Hello there.")
				Text("Try minimising this window to see a window docktile updating.")
			}
				.padding()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
