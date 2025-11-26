//
//  CoreDataStack.swift
//  ShowPolygonOnMapAssessment
//
//  Created by ShailajaK on 25/11/25.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer = {
        let c = NSPersistentContainer(name: "ShowPolygonOnMapAssessment") // change to your .xcdatamodeld name
        c.loadPersistentStores { _, error in
            if let error = error { fatalError("\(error)") }
        }
        return c
    }()
    
    var ctx: NSManagedObjectContext { container.viewContext }
}
