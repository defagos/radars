import SwiftUI

class Model: ObservableObject {
    deinit {
        print("--> Model deinit")
    }
}

struct DetailView: View {
    @StateObject private var model = Model()

    var body: some View {
        Text("Detail")
    }
}
