//
//  CustomCell.swift
//  frame_bound
//
//  Created by Nuhash on 5/16/22.
//

import UIKit

class CustomCell: UICollectionViewCell {

    @IBOutlet weak var labelView : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ flickerPhoto : FlickrPhoto){
        print(flickerPhoto.title , flickerPhoto.photoID)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 0
        labelView.text = flickerPhoto.title
        imageView.image = flickerPhoto.thumbnail
        imageView.layer.cornerRadius = 10
    }
    
    func unSelectCell(){
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.clear.cgColor
    }
    func selectCell(){
        self.layer.borderWidth = 3
        self.backgroundColor = UIColor.brown
        self.layer.borderColor = UIColor.yellow.cgColor
    }
    

}
