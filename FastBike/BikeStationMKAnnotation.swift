import MapKit

class BikeStationMKAnnotation: NSObject, MKAnnotation {

    let station: BikeStation

    init(station: BikeStation) {
        self.station = station
    }

    var coordinate: CLLocationCoordinate2D {
        return station.location.coordinate
    }

    var title: String? { return station.name }

    var subtitle: String? {
        let availableBikes = "\(station.bikes) Bici"
        let availableSlots = "\(station.slots)" + (station.slots == 1 ? " Posto" :  " Posti")
        return availableBikes + ", " + availableSlots
    }
}
