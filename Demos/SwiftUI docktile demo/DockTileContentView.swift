//
//  DockTileContentView.swift
//  SwiftUI docktile demo
//
//  Created by Darren Ford on 22/3/2022.
//

import SwiftUI

// The content to display in the dock tile
struct DockTileContentView: View {
	let percent: Int
	var body: some View {
		ZStack {
			Image("apple-icon")
				.resizable()
				.scaledToFit()
			VStack {
				Spacer()
				Text("\(percent)%")
					.foregroundColor(.white).bold()
					.font(Font.system(size: 30))
					.shadow(color: .black, radius: 1, x: 1, y: 2)
					.frame(maxWidth: .infinity)
					.background {
						RoundedRectangle(cornerRadius: 16)
							.fill(Color.blue.opacity(0.6))
					}
					.padding(4)
			}
		}
	}
}

struct DockTileContentView_Previews: PreviewProvider {
	static var previews: some View {
		DockTileContentView(percent: 12)
			.frame(width: 128, height: 128)
	}
}
