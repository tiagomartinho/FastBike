import CoreLocation
import MapKit

extension InterfaceController: CLLocationManagerDelegate {
    func getUserPosition() {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            location = CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
            setMapZoomIfNeeded(location: location!)
        }
    }

    func setMapZoomIfNeeded(location: CLLocation) {
        if mapZoomSet { return }
        mapZoomSet = true
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let locationRegion = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegionMake(locationRegion, span)
        mapView.setRegion(region)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
