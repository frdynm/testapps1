import Foundation

struct DestinationEntity: Identifiable, Equatable, Sendable {
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
}
