//
//  AppScrollCollectionView.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class AppScrollCollectionView: UICollectionView {
    let cellId = "AppScrollCollectionViewCell"
    let itemsPerRow : CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellId)
    }
    
    func initialize(){
        self.delegate = self
        self.dataSource = self
        self.reloadData()
       // let indexPath = IndexPath(row: 333, section: 0)
    }
}

extension AppScrollCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StaticData.appDataScroll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AppScrollCollectionViewCell
        else {
            preconditionFailure("invalid cell type")
        }
        cell.loadCell(StaticData.appDataScroll[indexPath.row%StaticData.appDataScroll.count])
        if(indexPath.row+1==StaticData.appDataScroll.count){
            cell.dummyView.isHidden = true
        }else{
            cell.dummyView.isHidden = false
        }
        return cell
    }
}
extension AppScrollCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getAvailableWidth(collectionView)
        let height = Int((85 * width)/333)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func getAvailableWidth(_ collectionView: UICollectionView) -> Int {
        let paddingSpace = (self.itemsPerRow + 1) * sectionInsets.left
        let availableWidth = collectionView.bounds.width - paddingSpace
        return Int(availableWidth / self.itemsPerRow)
    }
}
