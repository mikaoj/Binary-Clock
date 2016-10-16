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

protocol BinaryLayout {
    var items: [[ItemType]] { get }

    func itemSize(containedIn containerSize: CGSize) -> CGSize
    func itemSpacingFor(column: Int) -> CGFloat
    func columnSpacingFor(column: Int) -> CGFloat
}

enum ItemType {
    case binary(Bool?)
    case text(String)
    case decimal(Int)
}

struct Diff {
    var deleted: [IndexPath]
    var inserted: [IndexPath]
    var changed: [IndexPath]
}

extension ItemType: Equatable {
    static func ==(lhs: ItemType, rhs: ItemType) -> Bool {
        switch (lhs, rhs) {
        case (.binary(let first), .binary(let second)):
            return first == second
        default:
            return false
        }
    }
}
