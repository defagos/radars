import SwiftUI

fileprivate struct StackConfiguration {
    static let rows: Int = 20
    static let columns: Int = 50
}

struct StackExample: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<StackConfiguration.rows) { _ in
                    StackExampleRow()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
    }
}

fileprivate struct StackExampleRow: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<StackConfiguration.columns) { _ in
                    Button(action: {}) {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 320, height: 180)
                            .drawingGroup()
                    }
                }
            }
        }
    }
}

struct StackExample_Previews: PreviewProvider {
    static var previews: some View {
        StackExample()
    }
}
