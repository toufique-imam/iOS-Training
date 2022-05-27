//
//  TabCell.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import Foundation
import UIKit

class TabCell : UICollectionViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    
    func updateCell(name:String){
        lblTitle.text = name
        onUnSelect()
    }
    func onSelect(){
        lblTitle.font = .systemFont(ofSize: 20)
        lblTitle.backgroundColor = .brown
    }
    func onUnSelect(){
        lblTitle.font = .systemFont(ofSize: 17)
        lblTitle.backgroundColor = .none
    }
    
}
