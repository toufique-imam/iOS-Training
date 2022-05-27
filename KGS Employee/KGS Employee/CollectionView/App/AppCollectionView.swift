//
//  AppCollectionView.swift
//  tab_indicator
//
//  Created by Nuhash on 5/18/22.
//

import Foundation
import UIKit


class AppCollectionView : UICollectionView {
    let cellID = "AppCollectionViewCell"
    let sectionInsets = UIEdgeInsets(
        top: 0, left: 0, bottom: 0, right: 0)
    let itemsPerRow :CGFloat = 1
    let itemsPerCol :CGFloat = 1
    
    var scrollDelegate : ScrollDelegate? = nil
    
    //register the nib cell
    override func awakeFromNib() {
        let nibCell = UINib(nibName: self.cellID, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: self.cellID)
        self.initialize()
    }
    private func initialize(){
        self.dataSource = self
        self.delegate = self
        isPagingEnabled = true
    }
    func goToItem(row: Int){
        let indexPath = IndexPath(row: row, section: 0)
        print(indexPath)
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension AppCollectionView : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("called scrollViewDidEndDecelerating" , self.isPagingEnabled)
        scrollDelegate?.collectionViewScrollUpdate(scrollView , true)
    }
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        print("ScrollToItem " , self.isPagingEnabled)
        self.isPagingEnabled = false
        super.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        self.isPagingEnabled = true
        print("ScrollToItem " , self.isPagingEnabled)

    }
}

extension AppCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? AppCollectionViewCell
        else {
            preconditionFailure("invalid cell type")
        }
        let appInfo = StaticData.appDataHome[indexPath.row%3]
        cell.loadCell(appInfo: appInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AppCollectionViewCell
        else {
            preconditionFailure("invalid cell type")
        }
        let appInfo = StaticData.appDataHome[indexPath.row%3]
        cell.loadCell(appInfo: appInfo)
    }
}

extension AppCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getAvailableWidth(collectionView), height: getAvailableHeight(collectionView))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func getAvailableWidth(_ collectionView: UICollectionView) -> Int {
        let paddingSpace = (self.itemsPerRow + 1) * sectionInsets.left
        let availableWidth = collectionView.bounds.width - paddingSpace
        return Int(availableWidth / self.itemsPerRow)
    }
    
    func getAvailableHeight(_ collectionView: UICollectionView) -> Int {
        let paddingSpace = (self.itemsPerCol + 1) * sectionInsets.bottom
        let availableHeight = collectionView.bounds.height - paddingSpace
        return Int(availableHeight / self.itemsPerRow)
    }
}


