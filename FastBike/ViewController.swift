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
            showErrorAlert()
        }
    }

    @IBAction func findNearestStation() {
        if let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations),
            let userLocation = location {
            openMaps(start: userLocation, end: nearestStation.location)
        } else {
            showErrorAlert()
        }
    }

    func openMaps(start: CLLocation, end: CLLocation) {
        let start = MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate))
        let end = MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate))
        MKMapItem.openMaps(with: [start, end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Mi spiace 🤗",
                                      message: "Stai senza bici 🏃🏻",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok...", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
