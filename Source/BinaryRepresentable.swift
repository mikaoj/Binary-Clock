//
//  BinaryRepresentable.swift
//  Binary o'clock
//
//  Created by Home on 2016-10-13.
//  Copyright © 2016 backslashed. All rights reserved.
//

import Foundation
import UIKit

protocol BinaryRepresentable {
    func layoutFor(state: Bool?, style: UIUserInterfaceStyle)
}
