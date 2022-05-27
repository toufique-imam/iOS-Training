//
//  ListCollectionView.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import UIKit

class ListCollectionView : UICollectionView {
    let reuseIdentifier = "FlickrCell"
    let itemsPerCol = 1
    var dataDelegate : DataDelegate? = nil
    
    var selectedIndex : IndexPath? = nil {
        didSet{
            
            if let oldValue=oldValue,
            let cellOld = cellForItem(at: oldValue) {
                cellOld.layer.borderWidth = 3
            }
            
            if let newValue = selectedIndex,
               let cellNew = cellForItem(at: newValue) {
                cellNew.layer.borderWidth = 10
            }
            
        }
    }
    
    //TODO: add image tapped action
    
    var sectionNow = "IOS"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
    }
    
    func photo(indexPath: IndexPath)->FlickrPhoto? {
        return dataDelegate?.getDataAtIndex(sectionName: sectionNow, indexPath: indexPath)
    }
    func dataUpdated(){
        self.reloadData()
        dataDelegate?.dataVisible(sectionNow: sectionNow , idx: 0)
        //        dataDelegate?.clickedOnImage(flickrPhoto: )
        let indexPath = IndexPath(item: 9, section: 0)
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        dataDelegate?.clickedOnImage(flickrPhoto: photo(indexPath: indexPath)!)
        selectedIndex = indexPath
    }
}
extension ListCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataDelegate?.getDataCount(sectionName: sectionNow) ?? 0
        //return data[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FlickrPhotoCell
                
        else{
            preconditionFailure("invalide cell type")
        }
        if let flickrPhoto = photo(indexPath: indexPath){
            cell.updateCell(flickrPhoto)
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3
        if(selectedIndex==indexPath){
            cell.layer.borderWidth = 10
        }
        return cell
    }
}

extension ListCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: change the detail collection view
        //take a reference for HomeContoller
        //call HomeController function through protocol
        dataDelegate?.clickedOnImage(flickrPhoto: photo(indexPath: indexPath)!)
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedIndex = indexPath
    }
}
