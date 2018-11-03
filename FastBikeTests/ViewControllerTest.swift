import XCTest
@testable import FastBike

class ViewControllerTest: XCTestCase {
    func testCallBikeStationServiceAtViewDidLoad() {
        let service = SpyBikeStationService()
        let controller = ViewController(service: service)
        let _ = controller.view
        
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
