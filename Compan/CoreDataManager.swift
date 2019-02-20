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
}
