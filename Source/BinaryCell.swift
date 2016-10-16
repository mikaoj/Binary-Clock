// The MIT License (MIT)
//
// Copyright (c) 2016 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class BinaryCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.shadowRadius = 10
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
    }
}

extension BinaryCell: BinaryRepresentable {
    func layoutFor(state: Bool?, style: UIUserInterfaceStyle) {
        if let state = state {
            switch state {
            case true:
                alpha = 1
                switch style {
                case .dark:
                    backgroundColor = UIColor.ledBlue
                    layer.shadowColor = UIColor.ledBlue.cgColor
                case.light, .unspecified:
                    backgroundColor = UIColor.darkLedBlue
                    layer.shadowColor = UIColor.darkLedBlue.cgColor
                }
            case false:
                alpha = 1
                backgroundColor = UIColor.inactiveLed
                layer.shadowColor = UIColor.clear.cgColor
            }
        } else {
            alpha = 0
        }
    }
}
