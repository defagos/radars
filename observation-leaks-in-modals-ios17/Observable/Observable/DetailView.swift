import Observation
import SwiftUI

@Observable class Model {
    deinit {
        print("--> Model deinit")
    }
}

struct DetailView: View {
    @Bindable private var model = Model()

    var body: some View {
        Text("Detail")
    }
}
