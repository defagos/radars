import SwiftUI

struct StackWrappingExampleView: View {
    @State private var isLarge = false

    var body: some View {
        ZStack {
            Color.yellow
            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .scaleEffect(isLarge ? 2 : 1)
        }
        .animation(.easeInOut, value: isLarge)
        .onTapGesture {
            isLarge.toggle()
        }
    }
}

#Preview {
    StackWrappingExampleView()
}
