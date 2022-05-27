//
//  SettingsCollectionViewCell.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageIconLeft : UIImageView!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var imageIconRight : UIImageView!
    @IBOutlet weak var dummyView :  UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCellData(_ appInfo : AppInfo){
        imageIconLeft.image = UIImage(named: appInfo.imagePath)
        labelTitle.text = appInfo.name
    }
    
}
