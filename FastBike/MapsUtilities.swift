import CoreLocation
import MapKit

class MapUtilities {
    static func open(start: CLLocation, end: CLLocation) {
        let start = MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate, addressDictionary: nil))
        let end = MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate, addressDictionary: nil))
        MKMapItem.openMaps(with: [start, end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
}
