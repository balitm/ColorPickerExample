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

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!

    // Generate popover on button press.
    @IBAction func colorPickerButton(sender: UIButton) {
        let colorPicker = ColorPickerViewController.create(self, sender: sender)
        presentViewController(colorPicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ColorPickerViewDelegate {
    internal func colorPicker(picker: ColorPickerViewController, didSelectColor color: UIColor!) {
        button.setTitleColor(color, forState:UIControlState.Normal)
    }

    // For UIPopoverPresentationControllerDelegate: implement the iPhone behavior
    // that presents a popover as fullscreen
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
}