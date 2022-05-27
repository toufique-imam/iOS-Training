//
//  HomeController+SearchDelegate.swift
//  company
//
//  Created by Nuhash on 5/9/22.
//

import Foundation

extension HomeController : SearchDelegate {
    func clicked(name: String) {
        self.listCollectionView.sectionNow = name 
        self.getData(for: name)
        
    }
}
