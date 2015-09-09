

import Foundation
import MapKit

struct Station {
    
    var availableBikes:Int?
    var availableDocks:Int?
    var latitude:Float?
    var longitude:Float?
    var stationName:String?
    
    var mapPins: NSMutableArray = []
    
    init(json:NSDictionary) {
        if let bikeShareStations = json["stationBeanList"] as? NSArray {
            
            var bikeShareDepots = bikeShareStations
            
            for var i = 0; i < bikeShareDepots.count; i++ {
                
                var bikeShareData = bikeShareDepots[i] as? NSDictionary
                
                if let bikeShare = bikeShareData {
                    if let bike = bikeShare["availableBikes"] as? Int {
                        self.availableBikes = bike as Int
                        println(self.availableBikes!)
                    }
                    
                    if let dock = bikeShare["availableDocks"] as? Int {
                        self.availableDocks = dock as Int
                        println(self.availableDocks!)
                    }
                    
                    if let lat = bikeShare["latitude"] as? Float {
                        self.latitude = lat as Float
                        println(self.latitude!)
                    }
                    
                    if let long = bikeShare["longitude"] as? Float {
                        self.longitude = long as Float
                        println(self.longitude!)
                    }
                    if let station = bikeShare["stationName"] as? String {
                        self.stationName = station as String
                        println(self.stationName!)
                    }
                    
                    var pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude!), longitude: CLLocationDegrees(self.longitude!)),  title: self.stationName!, subtitle: "Bikes Available \(self.availableBikes!)")
                    
                    mapPins.addObject(pin)
                }
            }
        }
    }
}
