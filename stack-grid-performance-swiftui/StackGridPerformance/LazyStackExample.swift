import SwiftUI

fileprivate struct LazyStackConfiguration {
    static let rows: Int = 20
    static let columns: Int = 50
}

struct LazyStackExample: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<LazyStackConfiguration.rows) { _ in
                    LazyStackExampleRow()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
    }
}

fileprivate struct LazyStackExampleRow: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<LazyStackConfiguration.columns) { _ in
                    Button(action: {}) {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 320, height: 180)
                            .drawingGroup()
                    }
                }
            }
        }
    }
}

struct LazyStackExample_Previews: PreviewProvider {
    static var previews: some View {
        LazyStackExample()
    }
}
