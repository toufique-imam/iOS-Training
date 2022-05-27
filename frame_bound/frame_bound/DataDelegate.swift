//
//  DataDelegate.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import Foundation

protocol DataDelegate {
    func getDataCount(sectionName : String)->Int
    func getDataAtIndex(sectionName: String , indexPath:IndexPath)->FlickrPhoto
    func clickedOnImage(sectionNow:String , flickrPhoto: FlickrPhoto)
    func dataVisible(sectionNow:String , idx:Int)
    func setSelectedItem(sectionName:String , indexPath:IndexPath)
    func getSelectedItem()->(String,IndexPath?)
    func isSelectedItem(sectionName:String , indexPath : IndexPath)->Bool
}
