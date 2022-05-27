//
//  ViewController.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var listCollectionView : ListCollectionView!
    @IBOutlet weak var tabCollectionView : TabCollectionView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    let dummy = FlickrSearchResults(searchTerm: "", searchResults: [])
    var data : [FlickrSearchResults] = []
    let flickr = Flickr()
    var dataDownloaded : [Bool] = [false , false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.append(dummy)
        data.append(dummy)
        
        listCollectionView.dataDelegate = self
        tabCollectionView.searchDelegate = self
        
        
        getData(for: "IOS PHONE")
       // getData(for: "ANDROID PHONE")
        // Do any additional setup after loading the view.
    }
}


