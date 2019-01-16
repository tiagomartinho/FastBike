import XCTest
@testable import FastBike

class BikeStationTest: XCTestCase {
    func testDecodesSingleStation() {
        let jsonString = """
                        {
                            "name": "Grazioli",
                            "address": "Piazza Grazioli - Lavis",
                            "id": "Grazioli - Lavis",
                            "bikes": 4,
                            "slots": 6,
                            "totalSlots": 10,
                            "position": [
                              46.139732902099794,
                              11.111516155225331
                            ]
                          }
                        """

        let jsonData = jsonString.data(using: .utf8)!
        let station = try? JSONDecoder().decode(BikeStationNew.self, from: jsonData)

        XCTAssertEqual(4, station?.bikes)
        XCTAssertEqual("Grazioli", station?.name)
        XCTAssertEqual(11.111516155225331, station!.position.last!, accuracy: 0.000000000000001)
    }
}
