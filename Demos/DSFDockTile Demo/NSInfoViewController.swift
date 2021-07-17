//
//  NSInfoViewController.swift
//  DSFDockTile Demo
//
//  Created by Darren Ford on 16/7/21.
//

import AppKit

import DSFDockTile

class NSInfoViewController: NSViewController {
	override var nibName: NSNib.Name? {
		return NSNib.Name("NSInfoViewController")
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

	override func viewWillAppear() {
		super.viewWillAppear()

		DSFDockTile.AppIcon.display()
	}

}
