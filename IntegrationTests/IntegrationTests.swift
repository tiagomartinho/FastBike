import XCTest
@testable import FastBike

class TrentoBikeStationServiceTest: XCTestCase {

    func testIfReturning() {
        let expectation = XCTestExpectation(description: "Waiting for network request")
        let delegate = TrentoBikeStationServiceDelegate(expectation: expectation)
        let service = TrentoBikeStationService(delegate: delegate)

        service.getStations()

        wait(for: [expectation], timeout: 10)
        XCTAssertFalse(delegate.stations.isEmpty)
    }

    class TrentoBikeStationServiceDelegate:BikeStationServiceDelegate {
        var stations:[BikeStation] = []

        let expectation:XCTestExpectation
        init(expectation:XCTestExpectation){
            self.expectation = expectation
        }

        func set(bikeStations: [BikeStation]) {
            stations = bikeStations
            expectation.fulfill()
        }

    }
}
