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
            openMaps(start: userLocation, end: nearestBike.location)
        } else {
            AlertUtilities.showErrorAlert(viewController: self)
        }
    }

    @IBAction func findNearestStation() {
        if let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations),
            let userLocation = location {
            openMaps(start: userLocation, end: nearestStation.location)
        } else {
            AlertUtilities.showErrorAlert(viewController: self)
        }
    }

    func openMaps(start: CLLocation, end: CLLocation) {
        let start = MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate))
        let end = MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate))
        MKMapItem.openMaps(with: [start, end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
}
