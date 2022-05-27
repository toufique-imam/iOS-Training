//
//  ViewController.swift
//  tab_indicator
//
//  Created by Nuhash on 5/18/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var appCollectionView : AppCollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var flicker = Flickr()
    
    var photoData : [FlickrSearchResults] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        appCollectionView.dataDelegate = self
        pageControl.isHidden = true 
        getData(for: "farmhouse")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let page = sender.currentPage
        print("called page changed " , page)
        //appCollectionView.isPagingEnabled = false
        appCollectionView.goToItem(row: page)
    }
}

