import Foundation

class TrentinoBikeStationService: BikeStationService, BikeStationServiceDelegate {

    private let services: [BikeStationService]
    private weak var delegate: BikeStationServiceDelegate?

    init(services: [BikeStationService]) {
        self.services = services
    }

    func getStations(delegate: BikeStationServiceDelegate) {
        self.delegate = delegate
        services.forEach { $0.getStations(delegate: self) }
    }

    func set(bikeStations: [BikeStation]) {
        delegate?.set(bikeStations: bikeStations)
    }
}
