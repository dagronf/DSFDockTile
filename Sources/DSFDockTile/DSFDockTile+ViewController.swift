//
//  DSFDockTile+ViewController.swift
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

	/// Display the content of a view as a dock tile
	public class View: BaseType {

		/// The view controller
		internal weak var viewController: NSViewController?

		/// Create an instance which uses a view as the content of a docktile
		/// - Parameters:
		///   - viewController: The viewController handling the view being displayed in the dock tile. This parameter is weakly held by this object, so it's important to make sure you hold onto this view controller outside the instance
		///   - dockTile: The docktile to update. By default, updates the application docktile.
		public init(_ viewController: NSViewController, dockTile: NSDockTile = NSApp.dockTile) {
			self.viewController = viewController
			super.init(dockTile: dockTile)
		}

		// Set view as docktile
		public func display() {
			precondition(Thread.isMainThread)

			guard let tile = self.dockTile,
					let vc = self.viewController else {
				return
			}

			// Make sure the docktile is showing our view
			if tile.contentView !== vc.view {
				tile.contentView = vc.view
			}

			// And update the docktile display
			tile.display()
		}
	}
}
