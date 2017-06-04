# DisableConstraints #

This is an extension for the UIView class in Swift to make it easier to temporarily
disable and enable layout constraints for a certain view. Especially in UITableView and
UICollectionView cells, it is often useful to hide certain UI elements and show them
again when the cell is reused. However, layout constraints remain active while the
view is hidden, which is often not desired.

However, keeping track of all constraints is annoying, and disabling constraints without
storing references to them makes them deallocate. This extension will keep your disabled
constraints in safe storage until its time to enable them again.

For example, consider the case where we have three views, A, B and C, with spacing
constraints between each:

    [ A ] -- [ B ] -- [ C ]

If you hide B, then there will still be an empty space where it was, as its constraints
are still active. Setting up new constraints programmatically is a lot of work. Instead,
you can set up a lower-priority constraint between A and C, then hide B and disable its
constraints. The lower-priority constraint will now space A and C correctly, and once B
is shown and its constraints are re-enabled, the layout will return to what ir
originally was.

## Installation ##

Just download and copy DisableConstraints.swift into your project. It's just a single file.

## Usage ##

	// Hide view B and disable all constraints related to it.
	viewB.isHidden = true
	viewB.areConstraintsActive = false
	...
	// Show view B again and re-enable all constraints related to it.
	viewB.isHidden = false
	viewB.areConstraintsActive = true

## Author ##

Dag Ågren ([paracelsus@gmail.com](mailto:paracelsus@gmail.com),
[@WAHa_06x36](https://twitter.com/WAHa_06x36),
[@WAHa_06x36@mastodon.social](https://mastodon.social/@WAHa_06x36),
[wakaba.c3.cx](http://wakaba.c3.cx/))

## License ##

This code is released into the public domain with no warranties. If that
is not suitable, it is also available under the
[CC0 license](http://creativecommons.org/publicdomain/zero/1.0/).
