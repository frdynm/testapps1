import Foundation
import Combine

@MainActor
final class DestinationDetailViewModel: ObservableObject {
    @Published var destination: DestinationEntity

    init(destination: DestinationEntity) {
        self.destination = destination
    }

    // MARK: - Formatted Properties
    var formattedPopulation: String {
        formatNumber(destination.population)
    }

    var formattedPrice: String {
        "$\(destination.price)"
    }

    var formattedLatitude: String {
        String(format: "%.4f", destination.latitude)
    }

    var formattedLongitude: String {
        String(format: "%.4f", destination.longitude)
    }

    var photographerCredit: String {
        "Photo by \(destination.photographer)"
    }

    // MARK: - Public Methods
    func formatNumber(_ value: Int) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: value), number: .decimal)
    }
}
