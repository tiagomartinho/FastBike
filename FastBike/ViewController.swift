import UIKit
import Alamofire
import Gloss
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    var bikeStations = [BikeStation]()
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getBikeStations()
        getUserPosition()
    }

    @IBAction func findNearestBike() {
        if let nearestBike = BikeStationFinder.nearestBike(location: location, bikeStations: bikeStations),
            let userLocation = location {
            let start = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
            let end = MKMapItem(placemark: MKPlacemark(coordinate: nearestBike.location.coordinate))
            MKMapItem.openMaps(with: [start, end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        } else {
            showErrorAlert()
        }
    }

    @IBAction func findNearestStation() {
        if let nearestStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations),
            let userLocation = location {
            let start = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
            let end = MKMapItem(placemark: MKPlacemark(coordinate: nearestStation.location.coordinate))
            MKMapItem.openMaps(with: [start, end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        } else {
            showErrorAlert()
        }
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Mi spiace 🤗",
                                      message: "Stai senza bici 🏃🏻",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok...", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func getBikeStations() {
        if let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento") {
            Alamofire.request(url, method: .get).responseJSON { response in
                if let JSON = response.result.value as? [Gloss.JSON] {
                    for bikeJSON in JSON {
                        let bikeStation = BikeStation(json: bikeJSON)
                        self.bikeStations.append(bikeStation)
                        self.mapView.addAnnotation(bikeStation)
                    }
                }
            }
        }
    }

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

    var mapZoomSet = false

    func setMapZoomIfNeeded(location: CLLocation) {
        if mapZoomSet { return }
        mapZoomSet = true
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let locationRegion = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegionMake(locationRegion, span)
        mapView.setRegion(region, animated: false)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
