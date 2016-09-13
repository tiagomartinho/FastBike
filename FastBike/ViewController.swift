import UIKit

import Alamofire
import Gloss

class ViewController: UIViewController {

    var bikeStations = [BikeStation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getBikeStations()
    }

    func getBikeStations() {
        if let url = URL(string: "https://dev.smartcommunitylab.it/core.mobility/bikesharing/trento") {
            Alamofire.request(url, method: .get).responseJSON { response in
                if let JSON = response.result.value as? [Gloss.JSON] {
                    for bikeJSON in JSON {
                        self.bikeStations.append(BikeStation(json: bikeJSON))
                    }
                }
            }
        }
    }
}
