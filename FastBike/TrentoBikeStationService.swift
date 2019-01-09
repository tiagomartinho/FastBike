import Foundation

class TrentoBikeStationService: BikeStationService {

    private weak var delegate: BikeStationServiceDelegate?

    func getStations(delegate: BikeStationServiceDelegate) {
        self.delegate = delegate
        let url = URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/trento")!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: self.handleResponse)
        task.resume()
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?){
        switch (data, response, error){
        case let (_, _, error?):
                print(error.localizedDescription)
            
        case let (data?, response?, _) where self.isSuccess(response: response) :
            if let jsonData = self.getJson(from: data) {
                self.populateBikeStations(with: jsonData)
            }
            
        default:
            print("unhandled case")
        }
    }

    private func isSuccess(response: URLResponse) -> Bool {
        if let httpResponse = response as? HTTPURLResponse {
            return httpResponse.statusCode == 200
        }
        
        return false
    }

    private func getJson(from data: Data) -> [[String:AnyObject]]? {
        if let rawJson = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
            return rawJson as? [[String:AnyObject]]
        }
        return .none
    }

    func populateBikeStations(with json: [[String:AnyObject]]) {
        let bikeStations = json.map{ BikeStation(json: $0) }
        self.delegate?.set(bikeStations: bikeStations)
    }
}
