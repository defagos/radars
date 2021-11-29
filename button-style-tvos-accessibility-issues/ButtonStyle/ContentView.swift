import SwiftUI

struct SimplestButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct FocusableButtonStyle: ButtonStyle {
    let focused: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .cornerRadius(4)
            .scaleEffect(focused ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: focused)
    }
}

struct ContentView: View {
    private enum Field: Hashable {
        case focusableButton
    }
    
    @FocusState private var focusedField: Field?
    
    private var isFocusableButtonFocused: Bool {
        return focusedField == .focusableButton
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Button(action: {}) {
                Text("Plain")
            }
            .buttonStyle(.plain)
            
            Button(action: {}) {
                Text("Automatic")
            }
            .buttonStyle(.automatic)
            
            Button(action: {}) {
                Text("Simplest")
            }
            .buttonStyle(SimplestButtonStyle())
            
            Button(action: {}) {
                Text("Focusable")
            }
            .buttonStyle(FocusableButtonStyle(focused: isFocusableButtonFocused))
            .focused($focusedField, equals: .focusableButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
