//
//  TeamCollectionViewCell.swift
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData(teamName : String){
        label.text = teamName
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    func toggleButton(selected : Bool){
        if(selected){
            label.textColor = UIColor.white
            self.backgroundColor = UIColor.init(named: "TitleColor")!
        }else{
            self.backgroundColor = UIColor.white
            label.textColor = UIColor.init(named: "TextColorUnselected")!
        }
    }
}
