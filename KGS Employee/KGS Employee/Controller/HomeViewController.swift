//
//  HomeViewController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/24/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var pageControl : UIPageControl!
    
    @IBOutlet weak var appHomeCollectionView: AppCollectionView!
    
    @IBOutlet weak var buttonGettingStarted : UIButton!
    
    var timer = Timer()
    
    @IBAction func goToGetStarted(_ sender : UIButton) {
        let storyboard = UIStoryboard.init(name: "GetStarted", bundle: nil)
        let getStartedvc = storyboard.instantiateViewController(withIdentifier: "GetStartedController") as! GetStartedController
        self.navigationController?.pushViewController(getStartedvc, animated: true)
    }
    
    
    @IBAction func goToSettings(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
        let settingsPagevc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(settingsPagevc, animated: true)
        
    }
    
    @IBAction func goToApps(_ sender: UIBarButtonItem) {
        //TODO: go to apps section
        let storyboard = UIStoryboard.init(name: "AppsSettings", bundle: nil)
        let appSettingsPagevc = storyboard.instantiateViewController(withIdentifier: "AppsSettingsViewController") as! AppsSettingsViewController
        self.navigationController?.pushViewController(appSettingsPagevc, animated: true)
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        //TODO: fix this
        print("current page " , sender.currentPage)
        appHomeCollectionView.goToItem(row: sender.currentPage)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appHomeCollectionView.scrollDelegate = self
        initTime()
        initNavigationController()
        buttonGettingStarted.loadFont(fontName: "Poppins-SemiBold")
        buttonGettingStarted.dropShadow(color: UIColor(named: "DropShadow")!, opacity: 0.3, offset: CGSize(width: 1, height: -1), radius: 30, scale: false)
        buttonGettingStarted.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appHomeCollectionView.goToItem(row: 333)
        scheduledTimerWithTimeInterval()
    }
    
    private func initNavigationController(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    private func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            self.initTime()
        })
    }
    
    private func initTime(){
        let date = Date()
        let calendar = Calendar.current
        var hour = String(calendar.component(.hour, from: date))
        var minutes = String(calendar.component(.minute, from: date))
        
        while(hour.count<2){
            hour = "0" + hour
        }
        
        while(minutes.count<2){
            minutes = "0" + minutes
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let weekDay = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: date)
        
        let year = calendar.component(.year, from: date)
        labelTime.text = hour+":"+minutes
        labelDate.text = String(weekDay)+", "+String(month)+" "+String(year%100)
    }
}

extension HomeViewController : ScrollDelegate {
    func collectionViewScrollUpdate(_ scrollView: UIScrollView, _ ended: Bool) {
        print("called update scroll indicator " , self.pageControl.currentPage , scrollView.contentOffset)
        let x = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print(x)
        self.pageControl.currentPage = x % 3
        if(ended){
            self.appHomeCollectionView.goToItem(row: x)
        }
    }
}
