//
//  TeamViewController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

import UIKit

class TeamViewController: UIViewController {


    @IBOutlet weak var teamCollectionView : TeamCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamCollectionView.teamDataDelegate = self
        teamCollectionView.initialize()
      //  teamCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
}

extension TeamViewController : TeamDataDelegate {
    func getCount() -> Int {
        return StaticData.teamNames.count
    }
    
    func getCount(for indexPath: IndexPath) -> Int {
        return StaticData.employees[indexPath.row].count
    }
    
    func teamSelected(teamName: String) {
        //TODO send the data to employee controller
    }
    
    func employeeSelected(employee user: User) {
        //TODO send the data to imageview
    }
    
    func getTeamName(for indexPath: IndexPath) -> String {
        return StaticData.teamNames[indexPath.row]
    }
    
    func getEmployee(for indexPath: IndexPath) -> User {
        return StaticData.employees[indexPath.section][indexPath.row]
    }
    
}
