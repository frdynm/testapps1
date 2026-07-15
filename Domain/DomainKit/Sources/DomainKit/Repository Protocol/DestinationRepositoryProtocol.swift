import Foundation

// MARK: - Destination Repository Protocol
protocol DestinationRepositoryProtocol {
    func fetchDestinations() async throws -> [DestinationEntity]
}
