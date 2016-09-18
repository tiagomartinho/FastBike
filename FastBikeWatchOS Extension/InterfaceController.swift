import WatchKit
import Foundation
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
        let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento")!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] {
                        if let json = json {
                            for element in json {
                                if let element = element as? [String:AnyObject] {
                                    let bikeStation = BikeStation(json: element)
                                    self.bikeStations.append(bikeStation)
                                    self.mapView.addAnnotation(bikeStation.location.coordinate, with: WKInterfaceMapPinColor.red)
                                }
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
