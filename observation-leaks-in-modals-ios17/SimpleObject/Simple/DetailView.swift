import SwiftUI

class Model {
    deinit {
        print("--> Model deinit")
    }
}

struct DetailView: View {
    private var model = Model()

    var body: some View {
        Text("Detail")
    }
}
