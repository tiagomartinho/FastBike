import Gloss
import CoreLocation
import MapKit

class BikeStation: NSObject, Decodable {
    let name: String
    let address: String
    let id: String
    let bikes: Int
    let slots: Int
    let totalSlots: Int
    let location: CLLocation

    required init(json: JSON) {
        self.name = ("name" <~~ json) ?? ""
        self.address = ("address" <~~ json) ?? ""
        self.id = ("id" <~~ json) ?? ""
        self.bikes = ("bikes" <~~ json) ?? 0
        self.slots = ("slots" <~~ json) ?? 0
        self.totalSlots = ("totalSlots" <~~ json) ?? 0
        let positionArray: [Double] = ("position" <~~ json) ?? [0.0, 0.0]
        self.location = CLLocation(latitude: positionArray[0],
                                   longitude: positionArray[1])
    }
    
    init(name: String, address: String, id: String, bikes: Int, slots: Int, totalSlots: Int, location: CLLocation) {
        self.name = name
        self.address = address
        self.id = id
        self.bikes = bikes
        self.slots = slots
        self.totalSlots = totalSlots
        self.location = location
    }
}

extension BikeStation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }

    var title: String? { return name }

    var subtitle: String? {
        let availableBikes = "\(bikes) Bici"
        let availableSlots = "\(slots)" + (slots == 1 ? " Posto" :  " Posti")
        return availableBikes + ", " + availableSlots
    }
}
