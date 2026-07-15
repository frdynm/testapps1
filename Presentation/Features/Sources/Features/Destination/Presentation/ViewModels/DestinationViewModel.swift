import Foundation

// MARK: - Destination View Model
@MainActor
final class DestinationViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var destinations: [DestinationEntity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let fetchDestinationsUseCase: FetchDestinationsUseCase

    // MARK: - Init
    init(fetchDestinationsUseCase: FetchDestinationsUseCase) {
        self.fetchDestinationsUseCase = fetchDestinationsUseCase
    }

    // MARK: - Public Methods
    func loadDestinations() async {
        isLoading = true
        defer { isLoading = false }

        do {
            destinations = try await fetchDestinationsUseCase.execute()
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load destinations: \(error.localizedDescription)"
        }
    }
}
