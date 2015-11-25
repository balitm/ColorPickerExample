//
//  FlowLayout.swift
//  ColorPickerExample
//
//  Created by Balázs Kilvády on 11/24/15.
//  Copyright © 2015 kil-dev. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.scrollDirection = UICollectionViewScrollDirection.Vertical;
        self.minimumInteritemSpacing = 1;
        self.minimumLineSpacing = 1;
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 1.0, 0.0);
    }

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
