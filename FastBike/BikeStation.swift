import CoreLocation

struct BikeStation: Equatable {

    let name: String
    let address: String
    let id: String
    let bikes: Int
    let slots: Int
    let totalSlots: Int
    let location: CLLocation

    init(json: [String:AnyObject]) {
        self.name = (json["name"] as? String) ?? ""
        self.address = (json["address"] as? String) ?? ""
        self.id = (json["id"] as? String) ?? ""
        self.bikes = (json["bikes"] as? Int) ?? 0
        self.slots =  (json["slots"] as? Int) ?? 0
        self.totalSlots = (json["totalSlots"] as? Int) ?? 0
        let positionArray: [Double] = (json["position"] as? [Double]) ?? [0.0, 0.0]
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
