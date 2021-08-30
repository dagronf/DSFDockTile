//
//  DockViewController.swift
//  DockTile Stuff
//
//  Created by Darren Ford on 16/7/21.
//

import Cocoa

class DockViewController: NSViewController {

	override var nibName: NSNib.Name? {
		return NSNib.Name("DockViewController")
	}

	@IBOutlet weak var gradientArcView: GradientArcView!

	@objc dynamic var value: Double = 0 {
		didSet {
			gradientArcView.endAngle = CGFloat(360 * value)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}








@IBDesignable
class GradientArcView: NSView {

	 /// Width of the stroke.

	 @IBInspectable var lineWidth: CGFloat = 3             { didSet { setNeedsDisplay(bounds) } }

	 /// Color of the stroke (at full alpha, at the end).

	 @IBInspectable var strokeColor: NSColor = .blue       { didSet { setNeedsDisplay(bounds) } }

	 /// Where the arc should end, measured in degrees, where 0 = "3 o'clock".

	 @IBInspectable var endAngle: CGFloat = 0              { didSet { setNeedsDisplay(bounds) } }

	 /// What is the full angle of the arc, measured in degrees, e.g. 180 = half way around, 360 = all the way around, etc.

	 @IBInspectable var maxAngle: CGFloat = 360            { didSet { setNeedsDisplay(bounds) } }

	 /// What is the shape at the end of the arc.

	 var lineCapStyle: NSBezierPath.LineCapStyle = .square { didSet { setNeedsDisplay(bounds) } }

	 override func draw(_ dirtyRect: NSRect) {
		  super.draw(dirtyRect)

		  let gradations = 255

		  let startAngle = -endAngle + maxAngle
		  let center = NSPoint(x: bounds.midX, y: bounds.midY)
		  let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
		  var angle = startAngle

		  for i in 1 ... gradations {
				let percent = CGFloat(i) / CGFloat(gradations)
				let endAngle = startAngle - percent * maxAngle
				let path = NSBezierPath()
				path.lineWidth = lineWidth
				path.lineCapStyle = lineCapStyle
				path.appendArc(withCenter: center, radius: radius, startAngle: angle, endAngle: endAngle, clockwise: true)
				strokeColor.withAlphaComponent(percent).setStroke()
				path.stroke()
				angle = endAngle
		  }
	 }
}
