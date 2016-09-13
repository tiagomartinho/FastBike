import Foundation
import Alamofire
import Gloss

extension ViewController {
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
}
