//
//  AppSlideCollectionView.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class AppSlideCollectionView: UICollectionView {
    let cellId = "AppSlideCollectionViewCell"
    let itemsPerRow : CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    let scaleBigX : CGFloat = 280
    let scaleBigY : CGFloat = 156 , scaleSmallY = 136
    let scaleSmallX : CGFloat = 280 * 136 / 156
    var isFirstLoad  = true
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellId)
    }
    
    func initialize(){
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func goToItem(at row : Int , animated : Bool = false){
        let indexPath = IndexPath(row: row, section: 0)
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
}

extension AppSlideCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
     //   selectedItem = indexPath
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(isFirstLoad){
            goToItem(at: 333)
        }
        isFirstLoad = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width / 2
        for cell in self.visibleCells {
            var offsetX = centerX - cell.center.x
            //print(cell.center , cell.bounds , centerX , offsetX)
            if offsetX < 0 {
                offsetX *= -1
            }
            //cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            if(offsetX > 50){
                //make it smaller
                let offsetPercentage = (offsetX - 50) / self.bounds.width
                var scaleX = 1 - offsetPercentage
                scaleX = max(scaleX , 0.95)
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
            else{
                //make it bigger
                //offset joto kom toto bhalo
                offsetX = max(offsetX , 30)
                
                let scaleX = -0.005*offsetX + 1.25
                print(scaleX)
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
            //TODO: make it smoother
           // print(cell.frame)
        }
    }
}

extension AppSlideCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AppSlideCollectionViewCell
        else {
            preconditionFailure("invalid cell type")
        }
        
        cell.loadCell(StaticData.appDataBanner[indexPath.row%StaticData.appDataBanner.count])
        return cell
    }
}
extension AppSlideCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getAvailableWidth(collectionView)
        let height = Int((156 * width)/280)
        //print(width , height)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func getAvailableWidth(_ collectionView: UICollectionView) -> Int {
        let availableWidth = ((collectionView.bounds.width * 280)/375)/1.1
        return Int(availableWidth / self.itemsPerRow)
    }
}

