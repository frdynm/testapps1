import SwiftUI
// import Kingfisher // Uncomment after adding Kingfisher package

// TODO: Add SharedUI target dependency
// import SharedUI

// TODO: Add DesignSystem target dependency
// import DesignSystem

// TODO: Add LocalizationManager target dependency
// import LocalizationManager

struct DestinationListView: View {
    @StateObject private var viewModel: DestinationViewModel
    @State private var currentLanguage: Language = .systemLanguage

    init(viewModel: DestinationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle(testappsStrings.destinationsTitle)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        languageToggleButton
                    }
                }
                .task {
                    await viewModel.loadDestinations()
                }
        }
    }

    // MARK: - Content View
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .error(let message):
            errorView(message)
        case .loaded:
            destinationsList
        }
    }

    // MARK: - Loading View
    private var loadingView: some View {
        ProgressView(testappsStrings.generalLoading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Error View
    private func errorView(_ message: String) -> some View {
        VStack(spacing: AppSpacing.lg) {
            errorIcon
            errorMessage(message)
            retryButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(AppSpacing.xl)
    }

    private var errorIcon: some View {
        Image(systemName: "exclamationmark.triangle")
            .font(.largeTitle)
            .foregroundStyle(.orange)
    }

    private func errorMessage(_ message: String) -> some View {
        Text(message)
            .foregroundStyle(.red)
            .multilineTextAlignment(.center)
    }

    private var retryButton: some View {
        Button(testappsStrings.generalRetry) {
            Task {
                await viewModel.loadDestinations()
            }
        }
        .buttonStyle(.borderedProminent)
    }

    // MARK: - Destinations List
    private var destinationsList: some View {
        List(viewModel.destinations) { destination in
            NavigationLink(destination: DestinationDetailView(destination: destination)) {
                DestinationRowView(destination: destination)
            }
        }
        .listStyle(.insetGrouped)
    }

    // MARK: - Language Toggle Button
    private var languageToggleButton: some View {
        Button(action: toggleLanguage) {
            HStack(spacing: 4) {
                Image(systemName: "globe")
                Text(currentLanguage.rawValue.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.blue)
        }
    }

    private func toggleLanguage() {
        currentLanguage = currentLanguage == .en ? .id : .en
        LocalizationContainer.shared().setLanguage(currentLanguage)
    }
}
