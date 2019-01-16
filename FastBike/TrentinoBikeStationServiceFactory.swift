import Foundation

// https://www.europeandataportal.eu/data/en/dataset/stazioni-bikesharing-trentino

class TrentinoBikeStationServiceFactory {

    private static let endpoints = [
        "lavis",
        "mezzocorona",
        "mezzolombardo",
        "pergine_valsugana",
        "rovereto",
        "sanmichelealladige",
        "trento"
    ]

    private static let baseEndpoint = "https://os.smartcommunitylab.it/core.mobility/bikesharing/"

    static func get() -> [BikeStationService] {
        return endpoints
            .compactMap { URL(string: "\(baseEndpoint)\($0)") }
            .compactMap { TrentinoBikeStationService(url: $0) }
    }
}
