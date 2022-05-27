//
//  AppCollectionViewCell.swift
//  tab_indicator
//
//  Created by Nuhash on 5/18/22.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewLogo : UIImageView!
    @IBOutlet weak var imageViewLarge : UIImageView!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelDescription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(flickrPhoto : FlickrPhoto){
        //TODO: load the cell here
        imageViewLogo.image = flickrPhoto.thumbnail
        labelTitle.text = flickrPhoto.title
        labelDescription.text = flickrPhoto.photoID + " " + flickrPhoto.server + " "+flickrPhoto.title
        imageViewLarge.image = flickrPhoto.thumbnail

        flickrPhoto.loadLargeImage{ [weak self] result in
            guard let self = self else {
                return
            }
           // activityIndicator.stopAnimating()
            switch result {
            case .success(let photo):
                self.imageViewLarge.image = photo.largeImage
            case .failure:
                return
            }
        }
    }

}
