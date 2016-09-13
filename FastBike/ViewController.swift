import UIKit

import Alamofire
import Gloss
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    var bikeStations = [BikeStation]()
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getBikeStations()
        getUserPosition()
    }

    @IBAction func findNearestBikeStation() {
        if let nearestBikeStation = getNearestBikeStation() {
            print(nearestBikeStation)
        } else {
            let alert = UIAlertController(title: "Mi spiace 🤗",
                                          message: "Stai senza bici 🏃🏻",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok...", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func getNearestBikeStation() -> BikeStation? {
        guard let location = location else { return nil }
        var nearestBikeStation: BikeStation?
        for bikeStation in bikeStations {
            if bikeStation.bikes > 0 {
                if nearestBikeStation == nil {
                    nearestBikeStation = bikeStation
                } else {
                    let distance = location.distance(from: bikeStation.location)
                    let nearestBikeStationDistance = location.distance(from: nearestBikeStation!.location)
                    if distance < nearestBikeStationDistance {
                        nearestBikeStation = bikeStation
                    }
                }
            }
        }
        return nearestBikeStation
    }

    func getBikeStations() {
        if let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento") {
            Alamofire.request(url, method: .get).responseJSON { response in
                if let JSON = response.result.value as? [Gloss.JSON] {
                    for bikeJSON in JSON {
                        self.bikeStations.append(BikeStation(json: bikeJSON))
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
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
