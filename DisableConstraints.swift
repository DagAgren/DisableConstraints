import UIKit

extension UIView {
	var areConstaintsActive: Bool {
		get {
			return inactiveConstraints == nil
		}
		set(newValue) {
			let wereConstraintsAtive = areConstaintsActive

			guard newValue != wereConstraintsAtive else { return }

			if newValue {
				guard let constraints = inactiveConstraints else { return }
				NSLayoutConstraint.activate(constraints)
				inactiveConstraints = nil
			} else {
				let constraints = allConstraints
				NSLayoutConstraint.deactivate(constraints)
				inactiveConstraints = constraints
			}
		}
	}

	var allConstraints: [NSLayoutConstraint] {
		var constraints = self.constraints
		var parent = superview
		while parent != nil {
			constraints.append(contentsOf: parent!.constraints.filter({ $0.firstItem === self || $0.secondItem === self }))
			parent = parent!.superview
		}
		return constraints
	}

	private static var inactiveConstraintsHandle: UInt8 = 0
	private var inactiveConstraints: [NSLayoutConstraint]? {
		get {
           return objc_getAssociatedObject(self, &UIView.inactiveConstraintsHandle) as? [NSLayoutConstraint]
 		}
		set(newValue) {
           objc_setAssociatedObject(self, &UIView.inactiveConstraintsHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
 		}
	}
}

extension UIView {
	func hideAndDisableConstraints() {
		isHidden = true
		areConstaintsActive = false
	}

	func showAndEnableConstraints() {
		isHidden = false
		areConstaintsActive = true
	}
}
