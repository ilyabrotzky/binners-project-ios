//
//  BPAddress.swift
//  ios-binners-project
//
//  Created by Matheus Ruschel on 3/14/16.
//  Copyright © 2016 Rodrigo de Souza Reis. All rights reserved.

import UIKit
import MapKit


class BPAddress: NSObject, NSCoding {

    var formattedAddress: String!
    var location: CLLocationCoordinate2D!
    
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        
        guard
        let formattedAddress = decoder.decodeObjectForKey("formattedAddress") as? String,
        latitude = decoder.decodeObjectForKey("latitude") as? Double,
        longitude = decoder.decodeObjectForKey("longitude") as? Double else {
            
            fatalError("Could not decode object")
        }

        
        self.formattedAddress = formattedAddress
        self.location = CLLocationCoordinate2DMake(latitude, longitude)

    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(formattedAddress, forKey: "formattedAddress")
        coder.encodeObject(location.latitude, forKey: "latitude")
        coder.encodeObject(location.longitude, forKey: "longitude")
    }

}
func == (lhs:BPAddress, rhs:BPAddress) -> Bool {
    
    return (lhs.location.latitude == rhs.location.latitude) &&
        (lhs.location.longitude == rhs.location.longitude)
    
}