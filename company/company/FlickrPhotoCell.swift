//
//  FlickrPhotoCell.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import UIKit

class FlickrPhotoCell : UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
    func updateCell(_ flickrPhoto: FlickrPhoto){
        if let flickerImage = flickrPhoto.thumbnail {
            imageView.image = flickerImage
        }
    }
}
