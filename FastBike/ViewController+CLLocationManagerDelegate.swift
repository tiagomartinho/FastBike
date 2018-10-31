import CoreLocation
import MapKit

extension ViewController: CLLocationManagerDelegate {
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
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let locationRegion = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: locationRegion, span: span)
        mapView.setRegion(region, animated: false)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
