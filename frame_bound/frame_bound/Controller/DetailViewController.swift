//
//  DetailViewController.swift
//  frame_bound
//
//  Created by Nuhash on 5/16/22.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var flickrPhoto : FlickrPhoto? = nil
    
    
    func showImage(flickrPhoto : FlickrPhoto){
        self.flickrPhoto = flickrPhoto
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageView = imageView{
            imageView.backgroundColor = UIColor.yellow
            imageView.image = flickrPhoto?.thumbnail
            let activityIndicator = UIActivityIndicatorView(style: .large)
            view.addSubview(activityIndicator)
            activityIndicator.frame = view.bounds
            activityIndicator.startAnimating()
            
            flickrPhoto?.loadLargeImage{ [weak self] result in
                guard let self = self else {
                    return
                }
                activityIndicator.stopAnimating()
                switch result {
                case .success(let photo):
                    self.imageView.image = photo.largeImage
                case .failure:
                    return
                }
            }
        }
        else{
            print("null")
        }
    }
}
