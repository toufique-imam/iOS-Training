//
//  AppScrollCollectionViewCell.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class AppScrollCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var dummyView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(_ appInfo : AppInfo){
        imageLogo.image = UIImage(named: appInfo.iconPath)
        labelTitle.text = appInfo.name
        labelDescription.text = appInfo.description
    }
}
