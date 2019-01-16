import Foundation

class TrentinoBikeStationServiceFactory {

    private static let endpoints = [
        "lavis",
        "trento"
    ]
    private static let baseEndpoint = "https://os.smartcommunitylab.it/core.mobility/bikesharing/"

    static func get() -> [BikeStationService] {
        return endpoints
            .compactMap { URL(string: "\(baseEndpoint)\($0)") }
            .compactMap { TrentinoBikeStationService(url: $0) }
    }
}
