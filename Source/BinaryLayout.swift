//
//  BinaryLayout.swift
//  Binary o'clock
//
//  Created by Home on 2016-10-13.
//  Copyright © 2016 backslashed. All rights reserved.
//

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
