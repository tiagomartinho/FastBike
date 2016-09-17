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
            AlertUtilities.showErrorAlert(viewController: self, message: "Per usare l'applicazione devi permettere l'uso della tua posizione", action: "Attiva posizione")
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
            annotationView.pinTintColor = #colorLiteral(red: 0.1568627451, green: 0.8039215686, blue: 0.9843137255, alpha: 1)
            let button = UIButton(type: .detailDisclosure)
            button.setImage(#imageLiteral(resourceName: "freccetta"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "freccetta"), for: .highlighted)
            annotationView.rightCalloutAccessoryView = button
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
