//
//  EmployeesController.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var company: Company? {
        didSet {
            navigationItem.title = company?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        setupPlusButtonInNavBar(selector: #selector(handelAddEmployee))
    }
    
    @objc private func handelAddEmployee() {
        
        let createEmployeeController = CreateEmployeeController()
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController,animated: true)
    }
}
