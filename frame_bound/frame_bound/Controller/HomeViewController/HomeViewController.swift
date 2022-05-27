//
//  ViewController.swift
//  frame_bound
//
//  Created by Nuhash on 5/16/22.
//

import UIKit

class HomeViewController: UIViewController {
    var selectedItem : IndexPath? = nil
    var selectedSection = ""
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    static var getDataCalled = 0
    @IBOutlet weak var innerWidgetCollectionView : InnerWidgetCollectionView!
    
    
    var data : [FlickrSearchResults] = []
    let flickr = Flickr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerWidgetCollectionView.dataDelegate = self
        getData(for: "farmhouse")
        getData(for: "burger")
        getData(for: "pizza")
        getData(for: "building")
        getData(for: "pasta")
//        getData(for: "house")
//        getData(for: "big burger")
//        getData(for: "big pizza")
//        getData(for: "big building")
//        getData(for: "italian pasta")
//        getData(for: "calculator")
//        getData(for: "science")
//        getData(for: "clock")
//        getData(for: "watch")
//        getData(for: "macbook")
        
        // widgetCollectionView.dataDelegate = self
        
        //   getData(for: widgetCollectionView.sectionName)
    }
}

