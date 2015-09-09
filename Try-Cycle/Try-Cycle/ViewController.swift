
import UIKit
import MapKit 


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request a user's authorization for location services:
        

        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true

        
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        
  
        
        // Adding external web-service URL to the application as an NSURL object:
        var endpoint = NSURL(string: "http://www.bikesharetoronto.com/stations/json")
        
        // creating a data object that will return the formatted JSON, and pass the URL to it:
        var data = NSData(contentsOfURL: endpoint!)
        
        // printing "data" will return the raw data object.  Needs to be formatted into JSON.
        print(data)
        
        
        // The NSJSONSerialization class will handle the data object and create the serialzed JSON object (for later use)
        if let json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            
            var station = Station(json: json)
            
            for pins in station.mapPins {
                mapView.addAnnotation(pins as? MapPin)
            }
            
            // will return readable data that can be used to start plotting map.
            print(json)
            
            
            // Since current data is an array of dictionaries, we instruct the compiler to return an arrary of dictionaries.  Isolate one station at a time by specifying that within this dictionary, we have keys for available bikes, available docks, the latitude and longitude and station name.  
            if let bikeShareStations = json["stationBeanList"] as? NSArray {
                
                var bikeShareData = bikeShareStations[0] as? NSDictionary
            
                if let bikeShare = bikeShareData {
                    println(bikeShare["availableBikes"]!)
                    println(bikeShare["availableDocks"]!)
                    println(bikeShare["latitude"]!)
                    println(bikeShare["longitude"]!)
                    println(bikeShare["stationName"]!)
                }
            }
        }
        }
    



    }


}

