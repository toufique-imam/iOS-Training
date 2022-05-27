//
//  HomeViewController+DataDelegate.swift
//  frame_bound
//
//  Created by Nuhash on 5/17/22.
//

import UIKit
extension HomeViewController : DataDelegate {
    func setSelectedItem(sectionName: String, indexPath: IndexPath) {
        //TODO: Bug = if image is selected when another section is downloading then added the data
        //Section index doesn't match up and causes that cell to be uncleared
        let prevSection = getSectionByName(sectionName: self.selectedSection)
        
        if prevSection != -1  && prevSection != getSectionByName(sectionName: sectionName){
            let prevIndexPath = IndexPath(row: prevSection, section: 0)
            let tempInnerCollectionCell = self.innerWidgetCollectionView.cellForItem(at: prevIndexPath) as? InnerWidgetCollectionCell
            //print(tempInnerCollectionCell?.widgetCollectionView.sectionName)
            tempInnerCollectionCell?.widgetCollectionView.selectedItem = nil
        }
        self.selectedSection = sectionName
        self.selectedItem = indexPath
        let newSection = getSectionByName(sectionName: self.selectedSection)
        print("setSelectedItem" , newSection)
    }
    
    func getSelectedItem() -> (String, IndexPath?) {
        return (selectedSection , selectedItem)
    }
    
    func isSelectedItem(sectionName:String , indexPath : IndexPath)->Bool{
        if(sectionName==selectedSection && selectedItem==indexPath){
            return true
        }
        return false
    }
    
    func getSectionByName(sectionName : String) -> Int {
        for (index,x) in data.enumerated(){
            if(x.searchTerm == sectionName){
                return index
            }
        }
        return -1
    }
    
    func clickedOnImage(sectionNow:String , flickrPhoto: FlickrPhoto) {
        //TODO: open vc
        let Storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let secondVc = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.showImage(flickrPhoto: flickrPhoto)
        self.navigationController?.pushViewController(secondVc, animated: true)
    }
    
    func dataVisible(sectionNow: String, idx: Int) {
        //TODO: scroll to item
    }
    
    func getDataCount(sectionName: String) -> Int {
        let section = getSectionByName(sectionName: sectionName)
        if(data.isEmpty || section == -1 || section >= data.count){
            return 0
        }
        return data[section].searchResults.count
    }
    
    func getDataAtIndex(sectionName: String, indexPath: IndexPath) -> FlickrPhoto {
        let section = getSectionByName(sectionName: sectionName)
        if section != -1 {
            return data[section].searchResults[indexPath.row]
        }
        else {
            preconditionFailure("invalid index for section")
        }
    }
    func getData(for searchName:String){
        
        let section = getSectionByName(sectionName: searchName)
        
        if(section == -1){
            loadingActivityIndicator.startAnimating()
            HomeViewController.getDataCalled += 1
            flickr.searchFlickr(for: searchName){searchResult in
                DispatchQueue.main.async {
                    HomeViewController.getDataCalled -= 1 
                    if(HomeViewController.getDataCalled == 0) {
                        self.loadingActivityIndicator.stopAnimating()
                    }
                    switch searchResult {
                    case .failure(let error) :
                        print("error searching: \(error)")
                        
                    case .success(let results) :
                        //TODO: Reload data?
                        print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                        self.data.insert(results, at: 0)
                        self.innerWidgetCollectionView.updateData(name: searchName)
                    }
                }
            }
        }else{
            print("came here " , section)
            //data should all ready be provided
        }
    }

}
