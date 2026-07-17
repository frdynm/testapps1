import SwiftUI

struct RouteView: View {
    var body: some View {
        DestinationListView(viewModel: .make())
    }
}
