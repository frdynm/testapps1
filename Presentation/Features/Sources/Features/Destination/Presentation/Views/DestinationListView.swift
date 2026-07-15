import SwiftUI

// MARK: - Destination List View
struct DestinationListView: View {
    @StateObject private var viewModel: DestinationViewModel

    init(viewModel: DestinationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if let error = viewModel.errorMessage {
                    errorView(error)
                } else {
                    destinationsList
                }
            }
            .navigationTitle("Destinations")
            .task {
                await viewModel.loadDestinations()
            }
        }
    }

    // MARK: - Loading View
    private var loadingView: some View {
        ProgressView("Loading destinations...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Error View
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            Text(message)
                .foregroundStyle(.red)
            Button("Retry") {
                Task {
                    await viewModel.loadDestinations()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    // MARK: - Destinations List
    private var destinationsList: some View {
        List(viewModel.destinations) { destination in
            DestinationRowView(destination: destination)
        }
        .listStyle(.insetGrouped)
    }
}

// MARK: - Destination Row View
struct DestinationRowView: View {
    let destination: DestinationEntity

    var body: some View {
        HStack(spacing: 16) {
            // Flag
            AsyncImage(url: URL(string: destination.flagURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 30)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(destination.id)
                    .font(.headline)
                Text(destination.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Price
            Text("$\(destination.price)")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.1))
                .foregroundStyle(.blue)
                .clipShape(Capsule())
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = DestinationViewModel(
        fetchDestinationsUseCase: FetchDestinationsUseCase(
            repository: DestinationRepositoryImpl()
        )
    )
    return DestinationListView(viewModel: viewModel)
}
