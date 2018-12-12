protocol BikeStationService {
    func getStations()
    var delegate:BikeStationServiceDelegate? { get set }
}
