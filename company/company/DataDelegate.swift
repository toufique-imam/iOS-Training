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
    func clickedOnImage(flickrPhoto: FlickrPhoto)
    func dataVisible(sectionNow:String , idx:Int)
}
