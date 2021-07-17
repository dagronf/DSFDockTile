//
//  DSFDockTile+Core.swift
//  DSFDockTile
//
//  Created by Darren Ford on 17/7/21
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import AppKit

extension DSFDockTile {

	/// Base type for a docktile. Can only be inherited from
	public class BaseType {
		// The docktile to update. By default, this is the App Icon
		internal weak var dockTile: NSDockTile?

		/// Set the docktile badge label
		public var badgeLabel: String? {
			didSet {
				self.dockTile?.badgeLabel = self.badgeLabel
			}
		}

		internal init(dockTile: NSDockTile = NSApp.dockTile) {
			self.dockTile = dockTile
		}
	}
}

extension DSFDockTile {
	/// A docktile object that displays the default docktile content.
	public class AppIconType: BaseType {

		public override init(dockTile: NSDockTile = NSApp.dockTile) {
			super.init(dockTile: dockTile)
		}

		public func display() {
			if let tile = self.dockTile {
				tile.contentView = nil
				tile.display()
			}
		}
	}
}

