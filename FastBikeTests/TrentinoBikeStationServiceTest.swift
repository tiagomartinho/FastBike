import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {
    
    func testDelegateGetStationsToUnderlyingServices() {
        let delegate = MockBikeStationServiceDelegate()
        let firstService = MockBikeStationService()
        let secondService = MockBikeStationService()
        let service = TrentinoBikeStationService(delegate: delegate, services: firstService, secondService)

        service.getStations()

        XCTAssert(firstService.getStationsCalled)
        XCTAssert(secondService.getStationsCalled)
    }

    func testNotifyDelegateWhenSettingBikeStations() {
        let firstService = MockBikeStationService()
        let delegate = MockBikeStationServiceDelegate()
        let bikeStations = [BikeStation(json: [:])]
        let service = TrentinoBikeStationService(delegate: delegate, services: firstService)

        service.set(bikeStations: bikeStations)

        XCTAssertFalse(delegate.bikeStations.isEmpty)
    }

    class MockBikeStationServiceDelegate: BikeStationServiceDelegate {
        var bikeStations: [BikeStation] = []

        func set(bikeStations: [BikeStation]) {
            self.bikeStations = bikeStations
        }
    }

    class MockBikeStationService: BikeStationService {

        var delegate: BikeStationServiceDelegate?
        var getStationsCalled = false

        func getStations() {
            getStationsCalled = true
        }
    }
}

class TrentinoBikeStationService: BikeStationService, BikeStationServiceDelegate {

    private let services: [BikeStationService]
    weak var delegate: BikeStationServiceDelegate?
    
    init(delegate: BikeStationServiceDelegate, services: BikeStationService...) {
        self.delegate = delegate
        self.services = services
    }

    func getStations() {
        services.forEach { $0.getStations() }
    }

    func set(bikeStations: [BikeStation]) {
        delegate?.set(bikeStations: bikeStations)
    }
}
