//
//  ColorPickerDecorationView.swift
//  ColorPickerExample
//
//  Created by Balázs Kilvády on 11/24/15.
//  Copyright © 2015 kil-dev. All rights reserved.
//

import UIKit

class ColorPickerDecorationView: UICollectionReusableView {

    static let kind = "Background"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 242.0 / 256.0, 242.0 / 256.0, 242.0 / 256.0, 1.0);
        CGContextFillRect(context, rect);
    }
}
