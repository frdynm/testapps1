import Foundation

// MARK: - Destination DTO
struct DestinationDTO: Codable {
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

    enum CodingKeys: String, CodingKey {
        case id
        case country
        case photographer
        case price
        case population
        case latitude
        case longitude
        case description
        case imageURL = "imageURL"
        case flagURL = "flagURL"
    }
}

// MARK: - DTO to Entity Mapping
extension DestinationDTO {
    func toEntity() -> DestinationEntity {
        DestinationEntity(
            id: id,
            country: country,
            photographer: photographer,
            price: price,
            population: population,
            latitude: latitude,
            longitude: longitude,
            description: description,
            imageURL: imageURL,
            flagURL: flagURL
        )
    }
}
