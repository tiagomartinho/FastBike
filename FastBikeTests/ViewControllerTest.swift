import XCTest
@testable import FastBike

class ViewControllerTests: XCTestCase {
    func testDelegateGetBikeStationsToBikeStationService() {
        let controller = ViewController()
        let service = SpyBikeStationService()
        controller.service = service

        controller.viewDidLoad()

        XCTAssert(service.getBikeStationsWasCalled)
    }

    class SpyBikeStationService: BikeStationService {

        var getBikeStationsWasCalled = false

        func getStations() {
            getBikeStationsWasCalled = true
        }
    }
}
