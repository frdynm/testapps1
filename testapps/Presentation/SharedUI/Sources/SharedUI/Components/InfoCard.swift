import SwiftUI

public struct InfoCard: View {
    let title: String
    let value: String

    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.subheadline).fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12).background(.gray.opacity(0.1)).clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
