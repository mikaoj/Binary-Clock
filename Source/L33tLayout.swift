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

import Foundation
import CoreGraphics

struct L33tLayout {
    var items: [[ItemType]]

    init(date: Date = Date(), calendar: Calendar = Calendar.current) {
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        guard let hour = components.hour, let minute = components.minute, let second = components.second else { fatalError("Couldn't get date components") }

        let hours = [(hour/10).binary, (hour%10).binary]
        let minutes = [(minute/10).binary, (minute%10).binary]
        let seconds = [(second/10).binary, (second%10).binary]

        items =  [
            [.binary(nil), .binary(hours[1][3]), .binary(nil), .binary(minutes[1][3]), .binary(nil), .binary(seconds[1][3])],
            [.binary(nil), .binary(hours[1][2]), .binary(minutes[0][2]), .binary(minutes[1][2]), .binary(seconds[0][2]), .binary(seconds[1][2])],
            [.binary(hours[0][1]), .binary(hours[1][1]), .binary(minutes[0][1]), .binary(minutes[1][1]), .binary(seconds[0][1]), .binary(seconds[1][1])],
            [.binary(hours[0][0]), .binary(hours[1][0]), .binary(minutes[0][0]), .binary(minutes[1][0]), .binary(seconds[0][0]), .binary(seconds[1][0])],
        ]
    }
}

extension L33tLayout: BinaryLayout {
    func itemSize(containedIn containerSize: CGSize) -> CGSize {
        let height = containerSize.height - (CGFloat(items.count - 1)) * itemSpacingFor(column: 0)
        let itemHeight = height / CGFloat(items.count)
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    func itemSpacingFor(column: Int) -> CGFloat {
        return 40
    }

    func columnSpacingFor(column: Int) -> CGFloat {
        return 20
    }
}

private extension Int {
    // TODO: Can probably be improved
    var binary: [Bool] {
        var binary = Array(repeating: false, count: 4)
        var remaining = self
        var index = 0
        while index < 4 {
            binary[index] = (remaining % 2) != 0
            remaining = remaining / 2
            index += 1
        }

        return binary
    }
}
