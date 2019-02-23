//
//  UIViewController+Helpers.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupDoneButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
    }
}
