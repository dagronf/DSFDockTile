//
//  DSFDockTile+Attention.swift
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

/// Protocol for cancelling a user attention request
public protocol DSFDockTileUserAttentionCancellation {
	/// Cancels a previous user attention request.
	func cancel()
}

public extension DSFDockTile {
	/// User attention cancellation object
	struct UserAttention: DSFDockTileUserAttentionCancellation {
		public let identifier: Int
		@inlinable internal init(_ identifier: Int) {
			self.identifier = identifier
		}

		/// Cancels a previous user attention request.
		@inlinable public func cancel() {
			NSApp.cancelUserAttentionRequest(self.identifier)
		}
	}

	/// Starts a critical attention request
	/// - Returns: A cancel object
	///
	/// A request is canceled automatically by user activation of the app.
	///
	/// See:- [https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/criticalrequest](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/criticalrequest)
	@discardableResult
	@inlinable static func requestCriticalAttention() -> DSFDockTileUserAttentionCancellation {
		return UserAttention(NSApp.requestUserAttention(.criticalRequest))
	}

	/// Starts an informational attention request
	/// - Returns: A cancel object
	///
	/// See:- [https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/informationalrequest](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/informationalrequest)
	@discardableResult
	@inlinable static func requestInformationalAttention() -> DSFDockTileUserAttentionCancellation {
		return UserAttention(NSApp.requestUserAttention(.informationalRequest))
	}
}
