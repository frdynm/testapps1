import Foundation

// MARK: - Destination Dependency Injection
extension DestinationViewModel {
    static func make() -> DestinationViewModel {
        let networkManager = NetworkManager.shared
        let repository = DestinationRepositoryImpl(networkManager: networkManager)
        let useCase = FetchDestinationsUseCase(repository: repository)
        return DestinationViewModel(fetchDestinationsUseCase: useCase)
    }
}
