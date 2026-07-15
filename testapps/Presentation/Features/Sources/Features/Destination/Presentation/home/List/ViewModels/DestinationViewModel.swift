import Foundation
import Combine

// MARK: - View State
enum ViewState {
    case loading
    case loaded
    case error(String)
}

@MainActor
final class DestinationViewModel: ObservableObject {
    @Published var destinations: [DestinationEntity] = []
    @Published var state: ViewState = .loading

    private let fetchDestinationsUseCase: FetchDestinationsUseCase

    init(fetchDestinationsUseCase: FetchDestinationsUseCase) {
        self.fetchDestinationsUseCase = fetchDestinationsUseCase
    }

    // MARK: - Public Methods
    func loadDestinations() async {
        state = .loading

        do {
            destinations = try await fetchDestinationsUseCase.execute()
            state = .loaded
        } catch {
            state = .error("Failed: \(error.localizedDescription)")
        }
    }
}
