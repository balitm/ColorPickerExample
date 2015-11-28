/*
ColorPickerFlowLayout.swift
Created by Balázs Kilvády on 11/24/15.

The MIT License (MIT)

Copyright © 2015 Balázs Kilvády, kil-dev

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

class ColorPickerFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
        let cSize = collectionViewContentSize()
        layoutAttributes.frame = CGRect(x: 0.0, y: 0.0, width: cSize.width, height: cSize.height)
        layoutAttributes.zIndex = -1
        return layoutAttributes
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let cView = collectionView else {
            return nil
        }
        var ip = NSIndexPath(forItem: 0, inSection: 0)
        guard let attribute  = layoutAttributesForDecorationViewOfKind(ColorPickerDecorationView.kind, atIndexPath: ip) else {
            return nil
        }
        var allAttributes = [attribute]

        for i in 0..<cView.numberOfSections() {
            for j in 0..<cView.numberOfItemsInSection(i) {
                ip = NSIndexPath(forItem: j, inSection: i)
                allAttributes.append(layoutAttributesForItemAtIndexPath(ip)!)
            }
        }
        return allAttributes
    }
}
