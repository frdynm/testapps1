import Foundation

struct DestinationDTO: Codable, Sendable {
    let id: String
    let country: String
    let photographer: String
    let price: Int
    let population: Int
    let latitude: Double
    let longitude: Double
    let description: String
    let imageURL: String
    let flagURL: String

    func toEntity() -> DestinationEntity {
        DestinationEntity(id: id, country: country, photographer: photographer,
                          price: price, population: population, latitude: latitude,
                          longitude: longitude, description: description,
                          imageURL: imageURL, flagURL: flagURL)
    }
}
