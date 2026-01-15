import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ContentUnavailableView {
                TimeView()
            }
            Text("Some text")
        }
    }
}

//struct ZStackContentView: View {
//    var body: some View {
//        VStack {
//            ZStack {
//                TimeView()
//            }
//            Text("Some text")
//        }
//    }
//}
//
//struct NoTextContentView: View {
//    var body: some View {
//        VStack {
//            ContentUnavailableView {
//                TimeView()
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
