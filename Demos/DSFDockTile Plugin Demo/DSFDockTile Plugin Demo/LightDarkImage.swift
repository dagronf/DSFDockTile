//
//  LightDarkImage.swift
//  DSFDockTile Plugin Demo
//
//  Created by Darren Ford on 19/7/21.
//

import SwiftUI

struct LightDarkImage: View {
	@Environment(\.colorScheme) var scheme
	var body: some View {
		Group {
			if scheme == .light {
				Image("light").resizable()
			}
			else {
				Image("dark").resizable()
			}
		}
		.padding(0)
	}
}

struct LightDarkImage_Previews: PreviewProvider {
	static var previews: some View {
		HStack {
			LightDarkImage()//.previewLayout(.fixed(width: 196, height: 196))
				.environment(\.colorScheme, .light)
			LightDarkImage()//.previewLayout(.fixed(width: 196, height: 196))
				.environment(\.colorScheme, .dark)
		}
		.frame(width: 196 * 2, height: 196)
	}
}
