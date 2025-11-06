import Combine
import SwiftUI

private enum PickerOption: String, Hashable, CaseIterable {
    case one
    case two
    case three
}

private final class Model: ObservableObject {
    @Published private var date = Date()

    init() {
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .assign(to: &$date)
    }

    var dateString: String {
        String(date.timeIntervalSince1970)
    }
}

struct ContentView: View {
    @StateObject private var model = Model()
    @State private var pickerOption: PickerOption = .one

    var body: some View {
        VStack(spacing: 150) {
            Text(model.dateString)
            Menu {
                Picker(selection: $pickerOption) {
                    ForEach(PickerOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                } label: {
                    EmptyView()
                }
                .pickerStyle(.inline)
            } label: {
                Text("Menu")
            }
        }
    }
}

#Preview {
    ContentView()
}
