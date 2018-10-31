import XCTest

class FastBikeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.otherElements["Piazza della Mostra, 3 Bici, 8 Posti"].tap()
        app.buttons["bicivuota"].tap()

    }
}
