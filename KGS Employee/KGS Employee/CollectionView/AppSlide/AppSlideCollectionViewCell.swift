//
//  AppSlideCollectionViewCell.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class AppSlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMain: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(_ appInfo : AppInfo){
        imageMain.image = UIImage(named: appInfo.imagePath)
    }
}
