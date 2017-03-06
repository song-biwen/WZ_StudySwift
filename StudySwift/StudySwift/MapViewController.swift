//
//  MapViewController.swift
//  StudySwift
//
//  Created by songbiwen on 2017/3/3.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    var mapView:MKMapView?;
    var locationManager = CLLocationManager();
    var places = Places.getPlaces();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = "地图";
        
        requestLocationAcess();
        setupUI();
        
        addAnotation();
    }

    
    func addAnotation() {
        self.mapView?.delegate = self;
        self.mapView?.addAnnotations(self.places);
        
//        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        var overlays = [MKOverlay]();
        for place in places {
            let overlay = MKCircle(center: place.coordinate, radius: 200);
            overlays.append(overlay);
        }
        mapView?.addOverlays(overlays)
    }
    
    //获取权限
    func requestLocationAcess() {
        let status = CLLocationManager.authorizationStatus();
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            print("Location Acess Premitted");
        case .denied,.restricted:
            print("Location Acess Denied");
        default:
            self.locationManager.requestWhenInUseAuthorization();
            print("Location Acess Asked");
        }
        
    }
    
    func setupUI() {
        self.mapView = MKMapView();
        self.mapView?.frame = self.view.frame;
        self.view.addSubview(self.mapView!);
    }

    //MKMapViewDelegate
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "place icon");
            annotationView.annotation = annotation;
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black;
        renderer.strokeColor = UIColor.blue;
        renderer.lineWidth = 2;
        return renderer;
    }
}
