import Foundation

//extension ViewController {
//    func getBikeStations() {
//        let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento")!
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let task = session.dataTask(with: url, completionHandler: self.handleResponse)
//        task.resume()
//    }
//
//    private func handleResponse(data: Data?, response: URLResponse?, error: Error?){
//        switch (data, response, error){
//        case let (_, _, error?):
//                print(error.localizedDescription)
//
//        case let (data?, response?, _) where self.isSuccess(response: response) :
//            if let jsonData = self.getJson(from: data) {
//                self.populateBikeStations(with: jsonData)
//            }
//
//        default:
//            print("unhandled case")
//        }
//    }
//
//    private func isSuccess(response: URLResponse) -> Bool {
//        if let httpResponse = response as? HTTPURLResponse {
//            return httpResponse.statusCode == 200
//        }
//
//        return false
//    }
//
//    private func getJson(from data: Data) -> [[String:AnyObject]]? {
//        if let rawJson = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
//            return rawJson as? [[String:AnyObject]]
//        }
//
//        return .none
//    }
//
//    private func populateBikeStations(with json: [[String:AnyObject]]) {
//        json.map{ BikeStation(json: $0) }.forEach{ bikeStation in
//            self.bikeStations.append(bikeStation)
//            DispatchQueue.main.async {
//                self.mapView.addAnnotation(bikeStation)
//            }
//        }
//    }
//}
