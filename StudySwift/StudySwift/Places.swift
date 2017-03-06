//
//  Places.swift
//  StudySwift
//
//  Created by songbiwen on 2017/3/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit
import MapKit

@objc class Places: NSObject,MKAnnotation {
    var title:String?;
    var subtitle:String?;
    var coordinate:CLLocationCoordinate2D
    
    init(title:String?,subTitle:String?,coordinate:CLLocationCoordinate2D) {
        self.title = title;
        self.subtitle = subTitle;
        self.coordinate = coordinate;
    }
    
    
    static func getPlaces() -> [Places] {
        let filePath = Bundle.main.path(forResource: "Places", ofType: "plist");
        let array = NSArray(contentsOfFile: filePath!);
        var places = [Places]();
        
        for item in array! {
            var dict = item as! [String:Any];
            let title = dict["title"];
            let subTitle = dict["description"];
            let coordinate = CLLocationCoordinate2D(latitude: dict["latitude"] as! CLLocationDegrees, longitude: dict["longitude"] as! CLLocationDegrees);
            let place = Places(title: title as! String?, subTitle: subTitle as! String?, coordinate: coordinate);
            places.append(place);
        }
        return places;
    }
}
