import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {
    
    func testDelegateGetStationsToUnderlyingServices() {
        let delegate = MockBikeStationServiceDelegate()
        let firstService = MockBikeStationService()
        let secondService = MockBikeStationService()
        let service = TrentinoBikeStationService(services: [firstService, secondService])

        service.getStations(delegate: delegate)

        XCTAssert(firstService.getStationsCalled)
        XCTAssert(secondService.getStationsCalled)
    }

    func testNotifyDelegateWhenSettingBikeStations() {
        let delegate = MockBikeStationServiceDelegate()
        let service = TrentinoBikeStationService(services: [])
        service.getStations(delegate: delegate)

        service.set(bikeStations: [BikeStation(json: [:])])

        XCTAssertFalse(delegate.bikeStations.isEmpty)
    }

    class MockBikeStationServiceDelegate: BikeStationServiceDelegate {
        var bikeStations: [BikeStation] = []

        func set(bikeStations: [BikeStation]) {
            self.bikeStations = bikeStations
        }
    }

    class MockBikeStationService: BikeStationService {

        var getStationsCalled = false

        func getStations(delegate: BikeStationServiceDelegate) {
            getStationsCalled = true
        }
    }
}

