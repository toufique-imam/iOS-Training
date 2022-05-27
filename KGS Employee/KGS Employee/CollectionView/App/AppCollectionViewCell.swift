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
    
    func loadCell(appInfo : AppInfo){
        //TODO: load the cell here
        imageViewLogo.image = UIImage(named: appInfo.iconPath)
        imageViewLogo.layer.cornerRadius = 5
        labelTitle.text = appInfo.name
        labelDescription.text = appInfo.description
        imageViewLarge.image = UIImage(named: appInfo.imagePath)
        imageViewLarge.layer.cornerRadius = 10
    }

}
