//
//  CoreDataManager.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/20/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Compan")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchErr {
            print("Failed to fetch companies: \(fetchErr)")
            return []
        }
    }
    
    func createEmployee(WithName name: String, andCompany company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.setValue(name, forKey: "name")
        employee.company = company
        
        let epmployeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInfo", into: context) as! EmployeeInfo
        epmployeeInformation.taxID = "602"
        
        employee.employeeInformation = epmployeeInformation
        
        do {
            try context.save()
            return (employee, nil)
        } catch let saveErr {
            print("Fialed to Create new Employee:", saveErr)
            return (nil, saveErr)
        }
    }
}
