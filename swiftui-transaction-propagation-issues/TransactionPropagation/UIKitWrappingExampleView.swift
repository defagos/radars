import SwiftUI

private struct RepresentableZStack<Content>: UIViewControllerRepresentable where Content: View {
    @ViewBuilder var content: () -> Content

    func makeUIViewController(context: Context) -> UIHostingController<ZStack<Content>> {
        .init(rootView: ZStack {
            content()
        })
    }

    func updateUIViewController(_ uiViewController: UIHostingController<ZStack<Content>>, context: Context) {
        uiViewController.rootView = ZStack {
            content()
        }
    }
}

struct UIKitWrappingExampleView: View {
    @State private var isLarge = false

    var body: some View {
        RepresentableZStack {
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
    UIKitWrappingExampleView()
}
