//
//  PolygonViewModel.swift
//  ShowPolygonOnMapAssessment
//
//  Created by ShailajaK on 25/11/25.
//

import Foundation
import CoreData
import CoreLocation
import UIKit

class PolygonViewModel {

    private let context: NSManagedObjectContext = CoreDataStack.shared.ctx

    // SAVE POLYGON
    func savePolygon(_ coords: [CLLocationCoordinate2D]) {
        let stored = StoredPolygon(coordinates: coords)
        do {
            let data = try JSONEncoder().encode(stored)

            let entity = SavedPolygon(context: context)
            entity.data = data
            try context.save()

            print("SAVED:", coords)
        } catch {
            print("Failed to save polygon:", error)
        }
    }

    // FETCH POLYGON
    func fetchPolygons() -> [[CLLocationCoordinate2D]] {
        let req: NSFetchRequest<SavedPolygon> = SavedPolygon.fetchRequest()
        do {
            let results = try context.fetch(req)

            let polygons = results.compactMap { entity -> [CLLocationCoordinate2D] in
                guard let data = entity.data else { return [] }
                let decoded = try? JSONDecoder().decode(StoredPolygon.self, from: data)
                print("FETCHED:", decoded?.coordinates ?? [])
                return decoded?.coordinates ?? []
            }

            return polygons
        } catch {
            print("Failed to fetch polygons:", error)
            return []
        }
    }
}
