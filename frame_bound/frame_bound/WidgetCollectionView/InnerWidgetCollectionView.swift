//
//  InnerWidgetCollectionView.swift
//  frame_bound
//
//  Created by Nuhash on 5/17/22.
//

import Foundation
import UIKit

protocol ScrollPositionDelegate {
    func upadatePosition(_ sectionName : String , _ offset : CGPoint)
}

class InnerWidgetCollectionView : UICollectionView {
    let cellID = "InnerWidgetCollectionCell"
    let itemsPerRow : CGFloat = 3
    let itemsPerCol : CGFloat = 4
    var sectionNames : [String] = []
    
    var firstVisible : [IndexPath : CGPoint] = [:]
    
    var dataDelegate : DataDelegate? = nil
    
    let sectionInsets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: cellID, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellID)
        self.initialize()
    }
    func initialize(){
        self.dataSource = self
        self.delegate = self
    }
    func updateData(name:String){
        //   print("called data updated from InnerWidgetCollectionView " , self.bounds)
        sectionNames.insert(name, at: 0)
        self.reloadData()
    }
    
}

extension InnerWidgetCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? InnerWidgetCollectionCell
        else {
            preconditionFailure("invalid cell type 1")
        }
        print(self.sectionNames[indexPath.row] ,  indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? InnerWidgetCollectionCell{
            //cell.dataDelegate = self
            cell.widgetCollectionView.sectionName = self.sectionNames[indexPath.row]
            cell.loadData(dataDelegate: self)
            cell.widgetCollectionView.scrollPositionSaveDelegate = self
            if let offset = firstVisible[indexPath] {
                cell.widgetCollectionView.contentOffset = offset
            }else if (dataDelegate?.getDataCount(sectionName: sectionNames[indexPath.row]))! > 0 {
                cell.widgetCollectionView.contentOffset = CGPoint.zero
                //cell.widgetCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
        }
    }
    
}
extension InnerWidgetCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.bottom * (itemsPerCol+1)
        let availableHeight = collectionView.frame.height - paddingSpace
        let heightPerItem = availableHeight / self.itemsPerCol
        // print("inner cell size " , collectionView.frame.height , heightPerItem)
        return CGSize(width: collectionView.frame.width, height: floor(heightPerItem))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        self.sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.sectionInsets.bottom
    }
}
extension InnerWidgetCollectionView : DataDelegate {
    func getDataCount(sectionName: String) -> Int {
        dataDelegate?.getDataCount(sectionName: sectionName) ?? 0
    }
    
    func getDataAtIndex(sectionName: String, indexPath: IndexPath) -> FlickrPhoto {
        if let dataDelegate = dataDelegate {
            return dataDelegate.getDataAtIndex(sectionName: sectionName, indexPath: indexPath)
        }
        else{
            preconditionFailure("delegate not set")
        }
    }
    
    func clickedOnImage(sectionNow:String, flickrPhoto: FlickrPhoto) {
        if let dataDelegate = dataDelegate {
            //TODO: get the idx for the selected idx
            //Scroll the section to current idx
            if let idx = self.sectionNames.firstIndex(of: sectionNow){
                let indexPath = IndexPath(row: idx, section: 0)
                UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
                    self.scrollToItem(at: indexPath, at: .centeredVertically , animated: true)
                    self.cellForItem(at: indexPath)?.backgroundColor = UIColor.blue
                    
                }, completion: {_ in
                    self.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
                    dataDelegate.clickedOnImage(sectionNow: sectionNow,flickrPhoto: flickrPhoto)
                })
            }
            else {
                
            }
        }
        else{
            preconditionFailure("delegate not set")
        }
    }
    
    func dataVisible(sectionNow: String, idx: Int) {
        dataDelegate?.dataVisible(sectionNow: sectionNow, idx: idx)
    }
    
    func setSelectedItem(sectionName: String, indexPath: IndexPath) {
        dataDelegate?.setSelectedItem(sectionName: sectionName, indexPath: indexPath)
    }
    
    func getSelectedItem() -> (String, IndexPath?) {
        if let dataDelegate = dataDelegate {
            return dataDelegate.getSelectedItem()
        }
        else{
            preconditionFailure("delegate not set")
        }
    }
    
    func isSelectedItem(sectionName: String, indexPath: IndexPath) -> Bool {
        return dataDelegate?.isSelectedItem(sectionName: sectionName, indexPath: indexPath) == true
    }
}

extension InnerWidgetCollectionView : ScrollPositionDelegate {
    func upadatePosition(_ sectionName: String , _ offset : CGPoint) {
        if let idx = sectionNames.firstIndex(of: sectionName) {
            let index = IndexPath(row: idx, section: 0)
            firstVisible[index] = offset
        }
    }
}
