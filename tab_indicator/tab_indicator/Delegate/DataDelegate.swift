//
//  DataDelegate.swift
//  tab_indicator
//
//  Created by Nuhash on 5/18/22.
//

import Foundation
import UIKit


protocol DataDelegate {
    func getCount()->Int
    func getItemAtIndexPath(indexPath : IndexPath)->FlickrPhoto
    func updateScrollIndicator(_ scrollView : UIScrollView , _ ended: Bool)
}
