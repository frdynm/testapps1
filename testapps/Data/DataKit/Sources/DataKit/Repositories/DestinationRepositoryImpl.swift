import Foundation

final class DestinationRepositoryImpl: DestinationRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    private let endpoint = "https://www.hackingwithswift.com/samples/journeys/destinations.json"

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchDestinations() async throws -> [DestinationEntity] {
        let dtos: [DestinationDTO] = try await networkManager.fetch([DestinationDTO].self, from: endpoint)
        return dtos.map { $0.toEntity() }
    }
}
