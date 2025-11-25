//
//  PolygonModel.swift
//  ShowPolygonOnMapAssessment
//
//  Created by ShailajaK on 25/11/25.
//

import Foundation
import CoreLocation

struct StoredPolygon: Codable {
    let coordinates: [CLLocationCoordinate2D]
}

// CLLocationCoordinate2D Codable support
extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey { case lat, lon }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(latitude, forKey: .lat)
        try c.encode(longitude, forKey: .lon)
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let lat = try c.decode(CLLocationDegrees.self, forKey: .lat)
        let lon = try c.decode(CLLocationDegrees.self, forKey: .lon)
        self.init(latitude: lat, longitude: lon)
    }
}
