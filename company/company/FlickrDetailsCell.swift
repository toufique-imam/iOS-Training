//
//  FlickrDetailsCell.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import UIKit

class FlickrDetailsCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var designation : UILabel!
    func updateCell(_ flickrPhoto: FlickrPhoto){
        if let flickerImage = flickrPhoto.thumbnail {
            imageView.image = flickerImage
        }
        title.text = flickrPhoto.photoID
        designation.text = flickrPhoto.secret + " " + flickrPhoto.server
    }
}
