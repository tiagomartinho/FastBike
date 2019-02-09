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

    func testDecodeListOfStations() {
        let jsonString = """
                        [
                          {
                            "name": "Pressano",
                            "address": "Piazza della Croce - Pressano",
                            "id": "Pressano - Lavis",
                            "bikes": 3,
                            "slots": 4,
                            "totalSlots": 7,
                            "position": [
                              46.15368174037716,
                              11.106601229430453
                            ]
                          },
                          {
                            "name": "Stazione RFI",
                            "address": "Via Stazione - Lavis",
                            "id": "Stazione RFI - Lavis",
                            "bikes": 3,
                            "slots": 7,
                            "totalSlots": 10,
                            "position": [
                              46.148180371138814,
                              11.096753997622727
                            ]
                          }
                        ]
                        """
        let jsonData = jsonString.data(using: .utf8)!

        let stations = try? JSONDecoder().decode([BikeStationNew].self, from: jsonData)

        XCTAssertEqual("Piazza della Croce - Pressano", stations?.first?.address)
        XCTAssertEqual("Stazione RFI", stations?.last?.name)
    }
}
