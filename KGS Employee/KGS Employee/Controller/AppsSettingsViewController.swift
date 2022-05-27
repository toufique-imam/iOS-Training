//
//  AppsSettingsViewController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class AppsSettingsViewController: UIViewController {
    @IBOutlet weak var collectionViewSlide: AppSlideCollectionView!
    @IBOutlet weak var dummyView : UIView!
    @IBOutlet weak var collectionViewScroll: AppScrollCollectionView!
    @IBOutlet weak var buttonClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyView.clipsToBounds = true
        dummyView.layer.cornerRadius = 10
        dummyView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        dummyView.dropShadowRectTop(color: UIColor.init(named: "DropShadow")!, opacity: 1.0,
                                    offset: CGSize(width: 5, height: 5), radius: 30, scale: false)
        //collectionViewScroll.layer.cornerRadius = 20
        collectionViewSlide.initialize()
        collectionViewScroll.initialize()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        guard let customFont = UIFont(name: "SFProDisplay-Medium", size: 16) else {
            fatalError("""
                Failed to load the "SFPRODISPLAY-REGULAR" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        buttonClose.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
