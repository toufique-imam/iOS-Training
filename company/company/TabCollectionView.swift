//
//  TabCollectionView.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import Foundation
import UIKit

class TabCollectionView : UICollectionView {
    let reuseIdentifier = "tabCell"
    var data : [String] = ["IOS" , "ANDROID"]
    var searchDelegate : SearchDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
    }
}

extension TabCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TabCell
        else{
            preconditionFailure("invalide cell type")
        }
        cell.updateCell(name: data[indexPath.row])
        return cell
    }
}

extension TabCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchDelegate?.clicked(name: data[indexPath.row])
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if let cell = collectionView.cellForItem(at: indexPath) as? TabCell {
            cell.onSelect()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabCell {
            cell.onUnSelect()
        }
    }
}
