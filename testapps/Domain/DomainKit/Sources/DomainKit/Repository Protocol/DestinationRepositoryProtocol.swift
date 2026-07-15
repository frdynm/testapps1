import Foundation

protocol DestinationRepositoryProtocol {
    func fetchDestinations() async throws -> [DestinationEntity]
}
