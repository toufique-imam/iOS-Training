//
//  HomeViewController+DataDelegate.swift
//  tab_indicator
//
//  Created by Nuhash on 5/18/22.
//

import Foundation
import UIKit

extension HomeViewController : DataDelegate {
    func getCount() -> Int {
        if(photoData.isEmpty){
            return 0;
        }
        return photoData[0].searchResults.count
    }
    
    func getItemAtIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        if(photoData.isEmpty){
            print(indexPath)
            preconditionFailure("invalid index")
        }
        let idx = indexPath.row % self.getCount()
        return photoData[0].searchResults[idx]
    }
    
    func updateScrollIndicator(_ scrollView : UIScrollView ,_ ended : Bool = false) {
        print("called update scroll indicator " , self.pageControl.currentPage , scrollView.contentOffset)
        let x = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print(x)
        self.pageControl.currentPage = x
        if(ended){
            self.appCollectionView.goToItem(row: x)
        }
    }
    
    func getData(for searchName:String){
        loadingActivityIndicator.startAnimating()
        flicker.searchFlickr(for: searchName){searchResult in
            DispatchQueue.main.async {
                self.loadingActivityIndicator.stopAnimating()
                
                switch searchResult {
                case .failure(let error) :
                    print("error searching: \(error)")
                    
                case .success(let results) :
                    self.pageControl.numberOfPages = 1000
                    self.pageControl.isHidden = false 
                    print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                    self.photoData.insert(results, at: 0)
                    self.appCollectionView.updateData()
                    self.pageControl.currentPage = 499
                }
            }
        }
    }
}
