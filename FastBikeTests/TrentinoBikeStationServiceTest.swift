import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {

    func testPopulatingBikeService() {
        let controller = SpyBikeStationServiceDelegate()
        let service = TrentinoBikeStationService(url: URL(string: "foo")!)
        service.getStations(delegate: controller)

        service.populateBikeStations(with: [])
        
        XCTAssert(controller.setBikeStationsCalled)
    }

    class SpyBikeStationServiceDelegate:BikeStationServiceDelegate{
        var setBikeStationsCalled = false

        func set(bikeStations: [BikeStation]) {
            setBikeStationsCalled = true
        }
    }
}
