//
//  WidgetCollectionView.swift
//  frame_bound
//
//  Created by Nuhash on 5/16/22.
//

import UIKit

class WidgetCollectionView: UICollectionView  {
    
    let cellID = "CustomCell"
    let headerID = "WidgetHeaderView"
    let itemsPerRow :CGFloat =  3
    let itemsPerCol : CGFloat = 1
    var sectionName = "Farmhouse"
    
    var dataDelegate : DataDelegate? = nil
    var scrollPositionSaveDelegate : ScrollPositionDelegate? = nil
    
    var selectedItem : IndexPath? = nil {
        didSet{
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                if let oldValue = oldValue,
                   let cellOld = self.cellForItem(at: oldValue) as? CustomCell{
                    cellOld.unSelectCell()
                }
                if let newValue = self.selectedItem,
                   let cellNew = self.cellForItem(at: newValue) as? CustomCell {
                    cellNew.selectCell()
                    self.dataDelegate?.setSelectedItem(sectionName: self.sectionName, indexPath: newValue)
                }
            }, completion: { _ in
                self.clickedOnImage()
            })
        }
    }
    let sectionInsets = UIEdgeInsets(
        top: 5, left: 2, bottom: 5, right: 2)
    
    
    func clickedOnImage(){
        if let selectedItem = selectedItem,
           let flickrPhoto = photo(indexPath: selectedItem) {
            dataDelegate?.clickedOnImage(sectionNow: sectionName , flickrPhoto: flickrPhoto)
        }
    }
    override func awakeFromNib() {
        let nibCell = UINib(nibName: cellID, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellID)
        self.initialize()
    }
    
    func initialize(){
        self.dataSource = self
        self.delegate = self
    }
    func photo(indexPath: IndexPath)->FlickrPhoto? {
        return dataDelegate?.getDataAtIndex(sectionName: sectionName, indexPath: indexPath)
    }
    
    func dataUpdated(){
        self.reloadData()
        self.layoutIfNeeded()
    }
}

extension WidgetCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataDelegate?.getDataCount(sectionName: sectionName) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CustomCell
        else{
            preconditionFailure("invalid cell type")
        }
        if let flickrPhoto = photo(indexPath: indexPath){
            cell.loadData(flickrPhoto)
        }
        return cell
    }
    
}
extension WidgetCollectionView : UICollectionViewDelegateFlowLayout {
    //TODO: change spacing between cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpaceW = (self.itemsPerRow+1)*sectionInsets.left
        let availableWidth = collectionView.bounds.width - paddingSpaceW
        let widthPerItem = Int(availableWidth / self.itemsPerRow)
        
        return CGSize(width: widthPerItem, height: Int(collectionView.frame.height - 22))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
}

extension WidgetCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedItem = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CustomCell {
            if(dataDelegate?.isSelectedItem(sectionName: self.sectionName, indexPath: indexPath)==true){
                cell.selectCell()
            }
            else{
                cell.unSelectCell()
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll \(sectionName) " , scrollView.contentOffset)
        scrollPositionSaveDelegate?.upadatePosition(self.sectionName, scrollView.contentOffset)
    }
}
