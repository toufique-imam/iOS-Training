//
//  SettingsCollectionView.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class SettingsCollectionView: UICollectionView {
    let sectionHeaderTitlte = ["ABOUT" , "GENERAL"]
    let cellId = "SettingsCollectionViewCell"
    let headerId = "SettingsHeader"
    let itemsPerRow : CGFloat = 1
    let sectionInsets = UIEdgeInsets(
        top: 0, left: 20, bottom: 0, right: 20)
    
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        self.register(nibCell ,forCellWithReuseIdentifier: cellId)
    }
    func initialize(){
        self.delegate = self
        self.dataSource = self
    }
}

extension SettingsCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath)
            guard let settingsHeaderView = headerView as? SettingsHeaderView
            else { return headerView }
            settingsHeaderView.labelHeader.text = sectionHeaderTitlte[indexPath.section]
            return settingsHeaderView
        default:
            preconditionFailure("invalid element type")
        }
    }
    func borderThisCell(_ collectionView : UICollectionView , _ indexPath : IndexPath)->Bool{
        if(indexPath.row==0){
            return false
        }
        if(indexPath.row+1 == collectionView.numberOfItems(inSection: indexPath.section)){
            return false
        }
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        StaticData.settingsData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? SettingsCollectionViewCell
        else {
            preconditionFailure("invalid cell type")
        }
        cell.loadCellData(StaticData.settingsData[indexPath.section][indexPath.row])
        cell.dummyView.isHidden = false
       var arr:[UIView.ShadowPath] = [.left, .right]

        if(borderThisCell(collectionView, indexPath)){
            //cell.layer.borderWidth = 2
            //cell.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            if(indexPath.row==0){
                arr.append(.top)
                cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }
            else{
                arr.append(.bottom)
                cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                cell.dummyView.isHidden = true
                if(indexPath.section==1){
                    cell.labelTitle.textColor = UIColor(named: "LogOut")!
                }
            }
        }
        cell.dropShadowPath(cell.getPath(for: arr), color: UIColor(named: "DropShadow")!, opacity: 0.8, offset: CGSize(width: 1, height: 3), radius: 20, scale: false)
        
        return cell
    }
}

extension SettingsCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getAvailableWidth(collectionView)
        let height = Int((52 * width)/325)
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
