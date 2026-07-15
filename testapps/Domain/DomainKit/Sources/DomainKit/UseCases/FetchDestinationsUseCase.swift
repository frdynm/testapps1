import Foundation

final class FetchDestinationsUseCase {
    private let repository: DestinationRepositoryProtocol
    init(repository: DestinationRepositoryProtocol) { self.repository = repository }
    func execute() async throws -> [DestinationEntity] {
        return try await repository.fetchDestinations()
    }
}
