//
//  HomeController+FetchData.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import UIKit

extension HomeController : DataDelegate {
    func getData(for searchName:String){
        //TODO: Get data initially
        let sectionIndex = getSectionByName(sectionName: searchName)
        if(dataDownloaded[sectionIndex]==false){
            loadingActivityIndicator.startAnimating()
            flickr.searchFlickr(for: searchName){searchResult in
                DispatchQueue.main.async {
                    self.loadingActivityIndicator.stopAnimating()
                    switch searchResult {
                    case .failure(let error) :
                        print("error searching: \(error)")
                        
                    case .success(let results) :
                        //TODO: Reload data?
                        print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                        print(sectionIndex)
                        self.data[sectionIndex] = results
                        self.dataDownloaded[sectionIndex] = true
                        self.listCollectionView.dataUpdated()
                    }
                }
            }
        }else{
            self.listCollectionView.dataUpdated()
        }
    }
    func getSectionByName(sectionName : String) -> Int {
        return (sectionName.contains("IOS")) ? 0 : 1
    }
    func getDataCount(sectionName: String) -> Int {
        let section = getSectionByName(sectionName: sectionName)
        if(data.isEmpty){
            return 0
        }
        return data[section].searchResults.count
    }
    func getDataAtIndex(sectionName: String, indexPath: IndexPath) -> FlickrPhoto {
        let section = getSectionByName(sectionName: sectionName)
        return data[section].searchResults[indexPath.row]
    }
    func dataVisible(sectionNow: String, idx: Int=0){
       let section = getSectionByName(sectionName: sectionNow)
       clickedOnImage(flickrPhoto: data[section].searchResults[idx])
    }
    func clickedOnImage(flickrPhoto: FlickrPhoto) {
        //TODO: call detail collection
     //   print("here \(flickrPhoto.photoID)")
        lblTitle.text = flickrPhoto.photoID
        lblDesc.text = flickrPhoto.secret
        imageView.image = flickrPhoto.thumbnail
    }
}
