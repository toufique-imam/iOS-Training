//
//  HomeViewController+UITextFieldDelegate.swift
//  frame_bound
//
//  Created by Nuhash on 5/17/22.
//

import Foundation
import UIKit

extension HomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text , !text.isEmpty
        else { return true }
        
        getData(for: text)
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}
