//
//  SettingsViewController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/25/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsCollectionView : SettingsCollectionView!
    @IBOutlet weak var buttonClose : UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UIImage.init(named: <#T##String#>)
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
    
    override func viewDidLoad() {
        settingsCollectionView.initialize()
    }
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
