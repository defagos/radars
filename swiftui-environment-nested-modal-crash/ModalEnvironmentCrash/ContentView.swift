import Combine
import Observation
import SwiftUI

@Observable final class TestContext {
    let name = "Hello, world!"
}

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: showSheet) {
            Text("Show sheet")
        }
        .sheet(isPresented: $isPresented) {
            Modal()
        }
        .environment(TestContext())
    }

    private func showSheet() {
        isPresented.toggle()
    }
}

struct Modal: View {
    @Environment(TestContext.self) private var context
    @State private var isPresented = false

    var body: some View {
        VStack(spacing: 40) {
            Text(context.name)
            Button(action: showSheet) {
                Text("Show sheet")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .sheet(isPresented: $isPresented) {
            Sheet()
        }
    }

    private func showSheet() {
        isPresented.toggle()
    }
}

struct Sheet: View {
    @Environment(TestContext.self) private var context

    var body: some View {
        Text(context.name)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
    }
}

#Preview {
    ContentView()
}
