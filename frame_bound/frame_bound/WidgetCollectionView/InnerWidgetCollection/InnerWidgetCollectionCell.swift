//
//  InnerWidgetCollectionCell.swift
//  frame_bound
//
//  Created by Nuhash on 5/16/22.
//

import UIKit

class InnerWidgetCollectionCell: UICollectionViewCell {
    @IBOutlet weak var widgetCollectionView : WidgetCollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    //var dataDelegate : DataDelegate? = nil
    
   // var sectionName = "placeholder"
    //ami bhablam sifat bjai re niye dekhabo dekhi ei pic asce
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func loadData(dataDelegate : DataDelegate){
       // print("InnerWidgetCollectionCell bounds: " , self.bounds)
        widgetCollectionView.dataDelegate = dataDelegate
        widgetCollectionView.dataUpdated()
        titleLabel.text = widgetCollectionView.sectionName
    }
}

