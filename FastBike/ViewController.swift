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
        let nearestBike = BikeStationFinder.nearestBike(location: location, bikeStations: bikeStations)
        openMaps(destination: nearestBike)
    }

    @IBAction func findNearestStation() {
        let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations)
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
}
