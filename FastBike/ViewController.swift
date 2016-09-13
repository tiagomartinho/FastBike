import UIKit
import Gloss
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    var bikeStations = [BikeStation]()
    var location: CLLocation?
    var mapZoomSet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getBikeStations()
        getUserPosition()
    }

    @IBAction func findNearestBike() {
        if let nearestBike = BikeStationFinder.nearestBike(location: location, bikeStations: bikeStations),
            let userLocation = location {
            MapUtilities.open(start: userLocation, end: nearestBike.location)
        } else {
            AlertUtilities.showErrorAlert(viewController: self)
        }
    }

    @IBAction func findNearestStation() {
        if let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations),
            let userLocation = location {
            MapUtilities.open(start: userLocation, end: nearestStation.location)
        } else {
            AlertUtilities.showErrorAlert(viewController: self)
        }
    }
}
