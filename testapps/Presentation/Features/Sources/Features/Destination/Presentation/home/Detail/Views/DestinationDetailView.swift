import SwiftUI
// import Kingfisher // Uncomment after adding Kingfisher package

// TODO: Add SharedUI target dependency
// import SharedUI

// TODO: Add DesignSystem target dependency
// import DesignSystem

struct DestinationDetailView: View {
    @StateObject private var viewModel: DestinationDetailViewModel

    init(destination: DestinationEntity) {
        self._viewModel = StateObject(wrappedValue: DestinationDetailViewModel(destination: destination))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                heroImageSection
                contentSection
            }
        }
        .navigationTitle(viewModel.destination.id)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Hero Image Section
    private var heroImageSection: some View {
        ZStack(alignment: .bottomTrailing) {
            heroImage
            flagBadge
        }
    }

    private var heroImage: some View {
        AsyncImage(url: URL(string: viewModel.destination.imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView().frame(height: AppSize.heroImageHeight)
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fill)
            case .failure:
                Rectangle().fill(.gray.opacity(AppStyle.backgroundOpacity))
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: AppSize.heroImageHeight)
        .clipped()
    }

    private var flagBadge: some View {
        AsyncImage(url: URL(string: viewModel.destination.flagURL)) { phase in
            switch phase {
            case .empty:
                ProgressView().frame(
                    width: AppSize.flagBadgeWidth,
                    height: AppSize.flagBadgeHeight
                )
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "flag")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: AppSize.flagBadgeWidth, height: AppSize.flagBadgeHeight)
        .padding(AppSpacing.sm)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: AppSize.cornerRadiusMd))
        .padding(.trailing, AppSpacing.md)
        .padding(.bottom, AppSpacing.md)
    }

    // MARK: - Content Section
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            titleSection
            Divider()
            infoCardsSection
            Divider()
            photographerSection
            descriptionSection
        }
        .padding(.horizontal, AppSpacing.xl)
        .padding(.bottom, AppSpacing.lg)
        .padding(.top, AppSpacing.md)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text(viewModel.destination.id)
                .font(.title)
                .fontWeight(.bold)
            
            countryBadge
        }
    }

    private var countryBadge: some View {
        Text(viewModel.destination.country)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.horizontal, AppSpacing.cardInner)
            .padding(.vertical, AppSpacing.xs)
            .background(.blue.opacity(AppStyle.backgroundOpacity))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }

    private var infoCardsSection: some View {
        LazyVGrid(
            columns: [GridItem(.flexible()), GridItem(.flexible())],
            spacing: AppSpacing.md
        ) {
            InfoCard(title: "Population", value: viewModel.formattedPopulation)
            InfoCard(title: "Price", value: viewModel.formattedPrice)
            InfoCard(title: "Latitude", value: viewModel.formattedLatitude)
            InfoCard(title: "Longitude", value: viewModel.formattedLongitude)
        }
    }

    private var photographerSection: some View {
        HStack(spacing: AppSpacing.xs) {
            Image(systemName: "camera")
                .foregroundStyle(.secondary)
            Text(viewModel.photographerCredit)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var descriptionSection: some View {
        Text(viewModel.destination.description)
            .font(.body)
            .lineSpacing(AppStyle.lineSpacing)
    }
}
