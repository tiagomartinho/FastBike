protocol BikeStationService {
    func getStations()
}

import MapKit

protocol BikeStationServiceDelegate: class {
    var bikeStations: [BikeStation] { get set }
    var mapView: MKMapView! { get }
}
