/*

ColorPickerViewController.swift

Created by Ethan Strider on 11/28/14.

The MIT License (MIT)

Copyright (c) 2014 Ethan Strider, 2015 Balazs Kilvady

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

protocol ColorPickerViewDelegate: UIPopoverPresentationControllerDelegate {
    func colorPicker(picker: ColorPickerViewController, didSelectColor color: UIColor!)
}

class ColorPickerViewController: UIViewController {
    private static var kRows = 16
    private static var kColumns = 10
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

    var delegate: ColorPickerViewDelegate? = nil
    @IBOutlet weak var collectionView: UICollectionView!


    // This function converts from HTML colors (hex strings of the form '#ffffff') to UIColors.
    private class func hexStringToUIColor(hex: String) -> UIColor {
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

    class func create(delegate: ColorPickerViewDelegate, sender: UIView) -> ColorPickerViewController {
        let sb = UIStoryboard.init(name: "ColorPicker", bundle: nil)
        let popoverVC = sb.instantiateViewControllerWithIdentifier("colorPickerPopover") as! ColorPickerViewController

        popoverVC.modalPresentationStyle = .Popover
        popoverVC.preferredContentSize = CGSizeMake(269 + 2 * 8, 431 + 2 * 8)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .Any
            popoverController.delegate = delegate
            popoverVC.delegate = delegate
        }
        return popoverVC
    }

    override func viewDidLoad() {
        collectionView.collectionViewLayout.registerClass(ColorPickerDecorationView.self, forDecorationViewOfKind: "Background")
    }
}

extension ColorPickerViewController: UICollectionViewDataSource {
    // Returns the number of columns in a section of the collection view.
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorPickerViewController.kColumns
    }

    // Returns the number of sections (rows) in the collection view.
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return ColorPickerViewController.kRows
    }

    // Inilitializes the collection view cells
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        let tag = indexPath.section * ColorPickerViewController.kColumns + indexPath.item
        cell.backgroundColor = ColorPickerViewController._colorPalette[tag]
        cell.tag = tag

        return cell
    }
}

extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    // Handles when a collection view cell has been selected.
    internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)! as UICollectionViewCell
        let color = ColorPickerViewController._colorPalette[cell.tag]
        self.view.backgroundColor = color
        delegate?.colorPicker(self, didSelectColor: color)
    }
}