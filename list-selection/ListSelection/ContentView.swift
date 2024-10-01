import Observation
import SwiftUI

@Observable
final class ContentViewModel {
    var names = ["John", "Jane", "Alice", "Bob"]

    var selectedName: String? {
        didSet {
            print("--> [ContentViewModel] didSet: \(selectedName ?? "-")")
        }
    }
}

struct ContentView: View {
    @State private var model = ContentViewModel()

    var body: some View {
        List($model.names, id: \.self, editActions: .all, selection: $model.selectedName) { name in
            Text(name.wrappedValue)
        }
        .onChange(of: model.selectedName) { _, newValue in
            print("--> [ContentView] onChange: \(newValue ?? "-")")
        }
        .navigationTitle("Names")
    }
}

#Preview {
    ContentView()
}
