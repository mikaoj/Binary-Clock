//
//  ViewController.swift
//  Binary o'clock
//
//  Created by Home on 2016-10-12.
//  Copyright © 2016 backslashed. All rights reserved.
//

import UIKit

class BinaryClockViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    private var collectionViewFlowlayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }

    fileprivate var layout: BinaryLayout = L33tLayout() {
        didSet {
            updatedLayout(new: layout, old: oldValue)
        }
    }

    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }

    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // if pad pressed, toggle between modes
        // if play/pause press read time with voice synthesizer
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            self?.layout = L33tLayout()
        })
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func updatedLayout(new: BinaryLayout, old: BinaryLayout) {
        // TODO: Handle changing types of layout!
        // TODO: Calculate proper diff. Updated, deleted, inserted...
        precondition(new.items.count == old.items.count)
        guard let collectionView = collectionView else { return }


        var updated = [IndexPath]()
        for (section, items) in new.items.enumerated() {
            for (row, item) in items.enumerated() {
                guard item != old.items[section][row] else { continue }
                updated.append(IndexPath(item: row, section: section))
            }
        }

        collectionView.performBatchUpdates ({
            collectionView.reloadItems(at: updated)
        })
        /*UIView.animate(withDuration: 0.3, animations: {
            for (section, items) in new.items.enumerated() {
                for (row, item) in items.enumerated() {
                    guard item != old.items[section][row] else { continue }
                    switch item {
                    case .binary(let state):
                        guard let cell = collectionView.cellForItem(at: IndexPath(item: row, section: section)) as? BinaryCell else { break }
                        cell.layoutFor(state: state)
                    default:
                        fatalError("Not implemented")
                    }
                }
            }
        })*/
    }
}

// MARK: UICollectionViewDataSource
extension BinaryClockViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return layout.items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layout.items[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch layout.items[indexPath.section][indexPath.row] {
        case .binary(let state):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BinaryCell", for: indexPath) as! BinaryCell
            cell.layoutFor(state: state, style: traitCollection.userInterfaceStyle)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: UICollectionViewFlowDelegate
extension BinaryClockViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layout.itemSize(containedIn: collectionView.bounds.size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: layout.itemSpacingFor(column: section))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let itemSize = layout.itemSize(containedIn: collectionView.bounds.size)
        let totalItemWidth = CGFloat(layout.items[section].count) * itemSize.width
        let spacing = (collectionView.bounds.width - totalItemWidth) / CGFloat(layout.items[section].count - 1)
        return spacing
    }
}
