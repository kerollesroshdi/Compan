//
//  EmployeesController.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.insertRows(at: [IndexPath(row: employees.count - 1, section: 0)], with: .top)
    }
    
    
    var company: Company? {
        didSet {
            navigationItem.title = company?.name
        }
    }
    
    var employees = [Employee]()
    
    let cellId = "employeeCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .teal
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        let employee = employees[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        cell.textLabel?.text = "\(employee.name ?? "") -TaxID:  \(employee.employeeInformation?.taxID ?? "") - BD: \(dateFormatter.string(from: employee.employeeInformation?.birthday ?? Date()))"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupPlusButtonInNavBar(selector: #selector(handelAddEmployee))
    }
    
    @objc private func handelAddEmployee() {
        
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController,animated: true)
    }
    
    private func fetchEmployees() {
        
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        self.employees = companyEmployees
        
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//        do {
//            let employees = try context.fetch(request)
//            self.employees = employees
//        } catch let fetchErr {
//            print("Failed to fetch Employees:", fetchErr)
//        }
    }
}
