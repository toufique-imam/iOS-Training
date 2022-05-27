//
//  TeamCollectionView.swift
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

import UIKit

class TeamCollectionView: UICollectionView {
    
  //  let itemsPerRow : CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 20)
    //load the team name
    //when selected send the data to delegate and change the button
    var teamDataDelegate : TeamDataDelegate? = nil
    let cellId = "TeamCollectionViewCell"
    var selectedIndex : IndexPath? {
        didSet{
            print("selectedIndex " , oldValue , selectedIndex)
            if oldValue == selectedIndex {
                return
            }
            if let oldValue = oldValue,
               let cellOld = self.cellForItem(at: oldValue) as? TeamCollectionViewCell {
                cellOld.toggleButton(selected: false)
            }
            if let selectedIndex = selectedIndex,
               let cellNew = self.cellForItem(at: selectedIndex) as? TeamCollectionViewCell {
                cellNew.toggleButton(selected: true)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let nibCell = UINib(nibName: cellId, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellId)
    }
    
    func initialize(){
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
}

extension TeamCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamDataDelegate?.getCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? TeamCollectionViewCell
        else{
            fatalError("invalid cell type")
        }
        cell.loadData(teamName: teamDataDelegate?.getTeamName(for: indexPath) ?? "delegate not set")
        cell.toggleButton(selected: indexPath == selectedIndex)
        return cell
    }
}

extension TeamCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getAvailableWidth(collectionView)
        let height = Int((30 * width)/92)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func getAvailableWidth(_ collectionView: UICollectionView) -> Int {
        let paddingSpace =  sectionInsets.left //todo is it correct??
        let availableWidth = collectionView.bounds.width - paddingSpace
        return Int((97.0*availableWidth)/375.0)
    }
}

extension TeamCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("called")
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
     //   selectedItem = indexPath
        selectedIndex = indexPath
    }
}
