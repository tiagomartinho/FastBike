import Foundation

extension ViewController {
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
                                    DispatchQueue.main.async {
                                        self.mapView.addAnnotation(bikeStation)
                                    }
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
