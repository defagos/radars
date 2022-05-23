import SwiftUI

struct ContentView: View {
    struct Level1View: View {
        var body: some View {
#if true
            Level2View()
#endif
        }
    }
    
#if true
    struct Level2View: View {
        var body: some View {
            Color.green
        }
    }
#endif
    
    var body: some View {
        Level1View()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
