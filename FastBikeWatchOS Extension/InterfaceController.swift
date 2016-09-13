import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    @IBAction func findNearestBike() {
        print("findNearestBike")
    }

    @IBAction func findNearestStation() {
        print("findNearestStation")
    }
}
