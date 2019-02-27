//
//  EmployeesController.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit
import CoreData

class IntendedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
//        employees.append(employee)
//        tableView.insertRows(at: [IndexPath(row: employees.count - 1, section: 0)], with: .top)
        fetchEmployees()
        tableView.reloadData()
        
        // to animate tableView ReloadData
//        UIView.transition(with: tableView, duration: 0.30, options: .transitionCurlDown, animations: {
//            self.tableView.reloadData()
//        }, completion: nil)
    }
    
    
    var company: Company? {
        didSet {
            navigationItem.title = company?.name
        }
    }
    
    var employees = [Employee]()
    
    let cellId = "employeeCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .teal
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        cell.textLabel?.text = "\(employee.name ?? "") -TaxID:  \(employee.employeeInformation?.taxID ?? "") - BD: \(dateFormatter.string(from: employee.employeeInformation?.birthday ?? Date()))"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IntendedLabel()
        if section == 0 {
            label.text = "Short names"
        } else if section == 1 {
            label.text = "Long names"
        } else {
            label.text = "Really long names"
        }
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    var shortNamesEmployees = [Employee]()
    var longNamesEmployees = [Employee]()
    var reallyLongNamesEmployees = [Employee]()
    
    var allEmployees = [[Employee]]()
    
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
        
        shortNamesEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count < 6
            }
            return false
        })
        
        longNamesEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count > 6 && count < 9
            }
            return false
        })
        
        reallyLongNamesEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count > 9
            }
            return false
        })
        
        allEmployees = [shortNamesEmployees, longNamesEmployees, reallyLongNamesEmployees]
        
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
