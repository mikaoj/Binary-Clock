//
//  BinaryCell.swift
//  Binary o'clock
//
//  Created by Home on 2016-10-13.
//  Copyright © 2016 backslashed. All rights reserved.
//

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
