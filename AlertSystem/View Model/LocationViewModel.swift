import SwiftUI
import CoreLocation
import Combine

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    @Published var isLoading: Bool = true
    
    @Published var location: Location = Location(longitude: 0.0, latitude: 0.0, city: "", country: "")

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.lastLocation = location
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
        
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                self.isLoading = false
                
                if let error = error {
                    print("Error in reverse geocoding: \(error.localizedDescription)")
                } else if let placemark = placemarks?.first {
                    let city = placemark.locality
                    let country = placemark.country
                    
                    DispatchQueue.main.async {
                        self.setLocation(location: Location(longitude: longitude, latitude: latitude, city: city ?? "", country: country ?? ""))
                    }
                }
            }
        }
    }
    
    func getLocation() -> Location {
        return self.location
    }
    
    func setLocation(location: Location){
        self.location = location
    }
}
