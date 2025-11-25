//
//  ViewController.swift
//  ShowPolygonOnMapAssessment
//
//  Created by ShailajaK on 25/11/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let mapView = MKMapView()
    let vm = PolygonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mapView.frame = view.bounds
        mapView.delegate = self
        view.addSubview(mapView)
        saveDemoPolygon()
        drawPolygons()
    }

    // DEMO POLYGON
    func saveDemoPolygon() {
        let coords = [
            CLLocationCoordinate2D(latitude: 49.384358, longitude: -124.848974), // NW Washington
              CLLocationCoordinate2D(latitude: 32.534156, longitude: -124.409591), // SW California
              CLLocationCoordinate2D(latitude: 25.837377, longitude: -97.396381),  // South Texas
              CLLocationCoordinate2D(latitude: 36.500000, longitude: -89.249634),  // Mid-South Missouri/Kentucky
              CLLocationCoordinate2D(latitude: 47.459686, longitude: -92.014099),  // Minnesota
              CLLocationCoordinate2D(latitude: 49.384358, longitude: -95.153999)
        ]

        vm.savePolygon(coords)
    }

    /// DRAW FROM COREDATA
    func drawPolygons() {
        let polygons = vm.fetchPolygons()

        for coords in polygons {

            guard coords.count > 2 else { continue }

            // MARK: Add Annotations (Labels)
            for c in coords {
                let annotation = MKPointAnnotation()
                annotation.coordinate = c
                annotation.title = "Lat: \(String(format: "%.4f", c.latitude))"
                annotation.subtitle = "Lon: \(String(format: "%.4f", c.longitude))"
                mapView.addAnnotation(annotation)
            }

            // MARK:  Draw Polygon
            let polygon = MKPolygon(coordinates: coords, count: coords.count)
            mapView.addOverlay(polygon)

            // MARK: Auto Zoom
            mapView.setVisibleMapRect(
                polygon.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                animated: true
            )
        }
    }


    // RENDERER FOR POLYGON
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = .red
            renderer.fillColor = UIColor.red.withAlphaComponent(0.3)
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}



