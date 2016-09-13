import WatchKit
import Foundation
import Alamofire
import Gloss
import CoreLocation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var mapView: WKInterfaceMap!

    var bikeStations = [BikeStation]()
    var location: CLLocation?
    let locationManager = CLLocationManager()
    var mapZoomSet = false

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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

extension InterfaceController {
    func getBikeStations() {
        if let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento") {
            Alamofire.request(url, method: .get).responseJSON { response in
                if let JSON = response.result.value as? [Gloss.JSON] {
                    for bikeJSON in JSON {
                        let bikeStation = BikeStation(json: bikeJSON)
                        self.bikeStations.append(bikeStation)
                        self.mapView.addAnnotation(bikeStation.location.coordinate, with: WKInterfaceMapPinColor.red)
                    }
                }
            }
        }
    }
}
