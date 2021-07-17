//
//  AttentionViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 17/7/21.
//

import Cocoa
import DSFDockTile

class AttentionViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("AttentionViewController")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	@IBAction func informationalRequest(_ sender: Any) {
		self.activateOtherApplicationToLoseFocus()

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			DSFDockTile.requestInformationalAttention()
		}
	}

	@IBAction func criticalRequest(_ sender: Any) {
		self.activateOtherApplicationToLoseFocus()

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			DSFDockTile.requestCriticalAttention()
		}
	}


	func activateOtherApplicationToLoseFocus() {
		let prefsURL = URL(string: "x-apple.systempreferences:com.apple.preference")!
		NSWorkspace.shared.open(prefsURL)
	}
}
