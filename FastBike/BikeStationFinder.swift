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
        var nearestBikeStation: BikeStation?
        for bikeStation in bikeStations {
            if condition(bikeStation) {
                if nearestBikeStation == nil {
                    nearestBikeStation = bikeStation
                } else {
                    let distance = location.distance(from: bikeStation.location)
                    let nearestBikeStationDistance = location.distance(from: nearestBikeStation!.location)
                    if distance < nearestBikeStationDistance {
                        nearestBikeStation = bikeStation
                    }
                }
            }
        }
        return nearestBikeStation
    }
}
