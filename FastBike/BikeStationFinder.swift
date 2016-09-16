import CoreLocation

class BikeStationFinder {

    static func nearestBike(location: CLLocation?, bikeStations: [BikeStation]) -> BikeStation? {
        return nearest(location: location,
                       bikeStations: bikeStations) { $0.bikes > 0 }
    }

    static func nearestStation(location: CLLocation?, bikeStations: [BikeStation]) -> BikeStation? {
        return nearest(location: location,
                       bikeStations: bikeStations) { $0.slots > 0 }
    }

    static func nearest(location: CLLocation?,
                        bikeStations: [BikeStation],
                        condition: ((BikeStation) -> Bool)) -> BikeStation? {
        guard let location = location else { return nil }
        
        return bikeStations.filter(condition)
            .min { station1, station2 in
                location.distance(from: station1.location) < location.distance(from: station2.location)}
    }
}
