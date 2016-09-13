import UIKit
import Gloss
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var bikeStations = [BikeStation]()
    var location: CLLocation?
    var mapZoomSet = false
    @IBOutlet var reportButton: UIButton!
    @IBOutlet var bikeButton: UIButton!
    @IBOutlet var parkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getBikeStations()
        getUserPosition()
        Analytics.track(screen: "Main View")
        reportButton.setImage(#imageLiteral(resourceName: "lavoripiena"), for: .highlighted)
        bikeButton.setImage(#imageLiteral(resourceName: "bicipiena"), for: .highlighted)
        parkButton.setImage(#imageLiteral(resourceName: "Parcheggiopiena"), for: .highlighted)
    }

    @IBAction func findNearestBike() {
        let nearestBike = BikeStationFinder.nearestBike(location: location, bikeStations: bikeStations)
        track(action: "Station", bikeStation: nearestBike, location: location)
        openMaps(destination: nearestBike)
    }

    @IBAction func findNearestStation() {
        let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations)
        track(action: "Station", bikeStation: nearestStation, location: location)
        openMaps(destination: nearestStation)
    }

    func openMaps(destination: BikeStation?) {
        if let nearestBikelocation = destination?.location,
        let userLocation = location {
            MapUtilities.open(start: userLocation, end: nearestBikelocation)
        } else {
            AlertUtilities.showErrorAlert(viewController: self)
        }
    }

    func track(action: String, bikeStation: BikeStation?, location: CLLocation?) {
        let user = location?.stringValue() ?? ""
        let bike = bikeStation?.location.stringValue() ?? ""
        let label = "\(user) -> \(bike)"
        Analytics.track(category: "Get Directions",
                        action: "Find Nearest \(action)",
                        label: label)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is BikeStation {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "BikeStation")
            annotationView.canShowCallout = true
            // MARK: qui
            annotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
            return annotationView
        } else {
            return nil
        }
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        openMaps(destination: view.annotation as? BikeStation)
    }
}

extension CLLocation {
    func stringValue() -> String {
        let latitude: Double = self.coordinate.latitude
        let longitude: Double = self.coordinate.longitude
        return "{\(latitude),\(longitude)}"
    }
}
