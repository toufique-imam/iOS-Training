//
//  GetStartedController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

import UIKit

class GetStartedController : UIViewController {
    @IBOutlet weak var bottomTabBar : UITabBar!
    @IBOutlet weak var containerView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomTabBar.tintColor = UIColor.init(named: "TitleColor")!
        bottomTabBar.unselectedItemTintColor = UIColor.init(named: "TabUnselected")!
        let offset = UIOffset(horizontal: 0, vertical: -18)
        if let items = bottomTabBar.items {
            for tabItem in items {
                if(bottomTabBar.selectedItem==nil){
                    bottomTabBar.selectedItem = tabItem
                }
                tabItem.titlePositionAdjustment = offset
            }
        }else{
            print("no item found")
        }
        loadSports()
        //loadTeams()
    }
    func loadTeams(){
        let storyboard = UIStoryboard.init(name: "Team", bundle: nil)
        
        let teamvc = storyboard.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        teamvc.view.frame = containerView.bounds
        containerView.addSubview(teamvc.view)
        //addChild(teamvc)
        addChild(teamvc)
        containerView.didMoveToWindow()
    }
    func loadSports(){
        let storyboard = UIStoryboard.init(name: "Sports", bundle: nil)
        
        let teamvc = storyboard.instantiateViewController(withIdentifier: "SportsViewController") as! SportsViewController
        teamvc.view.frame = containerView.bounds
        containerView.addSubview(teamvc.view)
        //addChild(teamvc)
        addChild(teamvc)
        containerView.didMoveToWindow()
    }
}
