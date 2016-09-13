import XCTest
import CoreLocation
@testable import FastBike

class BikeStationFinderTests: XCTestCase {
    func testFindsNearestBike() {
        let location = CLLocation(latitude: 42, longitude: 42)
        let noBikesStationLocation = CLLocation(latitude: 43, longitude: 41)
        let bikesStationLocation = CLLocation(latitude: 50, longitude: 50)
        let noBikesStation = BikeStation(name: "", address: "", id: "", bikes: 0, slots: 20, totalSlots: 20, location: noBikesStationLocation)
        let bikesStation = BikeStation(name: "", address: "", id: "", bikes: 1, slots: 20, totalSlots: 20, location: bikesStationLocation)
        let bikeStations = [noBikesStation, bikesStation]

        let foundBikeStation = BikeStationFinder.nearestBike(location: location, bikeStations: bikeStations)

        XCTAssertEqual(bikesStation, foundBikeStation)
    }

    func testFindsNearestStation() {
        let location = CLLocation(latitude: 42, longitude: 42)
        let fullStationLocation = CLLocation(latitude: 43, longitude: 41)
        let vacantStationLocation = CLLocation(latitude: 50, longitude: 50)
        let fullStation = BikeStation(name: "", address: "", id: "", bikes: 20, slots: 0, totalSlots: 20, location: fullStationLocation)
        let vacantStation = BikeStation(name: "", address: "", id: "", bikes: 1, slots: 20, totalSlots: 20, location: vacantStationLocation)
        let bikeStations = [fullStation, vacantStation]

        let foundBikeStation = BikeStationFinder.nearestStation(location: location, bikeStations: bikeStations)

        XCTAssertEqual(vacantStation, foundBikeStation)
    }
}
