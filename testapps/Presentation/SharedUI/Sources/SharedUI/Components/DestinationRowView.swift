import SwiftUI
// import Kingfisher // Uncomment after adding Kingfisher package

struct DestinationRowView: View {
    let destination: DestinationEntity

    var body: some View {
        HStack(spacing: 16) {
            // Flag - use KFImage after adding Kingfisher
            flagImage

            VStack(alignment: .leading, spacing: 4) {
                Text(destination.id)
                    .font(.headline)
                Text(destination.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            priceBadge
        }
        .padding(.vertical, 4)
    }

    // MARK: - Components
    private var flagImage: some View {
        AsyncImage(url: URL(string: destination.flagURL)) { phase in
            switch phase {
            case .empty:
                ProgressView().frame(width: 40, height: 30)
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "flag").foregroundStyle(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 40, height: 30)
    }

    private var priceBadge: some View {
        Text(formattedPrice)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.blue.opacity(0.1))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }

    // MARK: - Helpers
    private var formattedPrice: String {
        "$\(destination.price)"
    }
}
