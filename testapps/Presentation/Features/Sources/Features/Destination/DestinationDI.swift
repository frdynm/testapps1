import Foundation

// MARK: - Dependency Injection Extensions
extension DestinationViewModel {
    static func make() -> DestinationViewModel {
        let repository = DestinationRepositoryImpl()
        let useCase = FetchDestinationsUseCase(repository: repository)
        return DestinationViewModel(fetchDestinationsUseCase: useCase)
    }
}

extension DestinationDetailViewModel {
    static func make(destination: DestinationEntity) -> DestinationDetailViewModel {
        return DestinationDetailViewModel(destination: destination)
    }
}
