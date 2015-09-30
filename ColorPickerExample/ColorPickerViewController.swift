/*

ColorPickerViewController.swift

Created by Ethan Strider on 11/28/14.

The MIT License (MIT)

Copyright (c) 2014 Ethan Strider

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

import UIKit

class ColorPickerViewController: UIViewController {

	private static var kRows = 10
	private static var kColumns = 16
	private static let _colorPalette: [UIColor] = {
		// Get colorPalette array from plist file
		let path = NSBundle.mainBundle().pathForResource("colorPalette", ofType: "plist")
		guard let pListArray = NSArray(contentsOfFile: path!) else {
			return [UIColor]()
		}

		var colors = [UIColor]()
		for hexString in pListArray {
			let color = ColorPickerViewController.hexStringToUIColor(hexString as! String)
			colors.append(color)
		}
		return colors
	}()
	
	var color: UIColor = UIColor.grayColor()
	var delegate: ViewController? = nil


	// This function converts from HTML colors (hex strings of the form '#ffffff') to UIColors.
	private static func hexStringToUIColor(hex: String) -> UIColor {
		var cString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString

		if (cString.hasPrefix("#")) {
			cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
		}

		if (cString.characters.count != 6) {
			return UIColor.grayColor()
		}

		var rgbValue:UInt32 = 0
		NSScanner(string: cString).scanHexInt(&rgbValue)

		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}

extension ColorPickerViewController: UICollectionViewDataSource {
	// Returns the number of rows in a section of the collection view.
	internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return ColorPickerViewController.kRows
	}

	// Returns the number of sections (columns) in the collection view.
	internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return ColorPickerViewController.kColumns
	}

	// Inilitializes the collection view cells
	internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
		cell.backgroundColor = UIColor.clearColor()
		cell.tag = indexPath.section * ColorPickerViewController.kRows + indexPath.item

		return cell
	}
}

extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
	// Handles when a collection view cell has been selected.
	internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let cell = collectionView.cellForItemAtIndexPath(indexPath)! as UICollectionViewCell
		color = ColorPickerViewController._colorPalette[cell.tag]
		self.view.backgroundColor = color
		delegate?.setButtonColor(color)
	}
}