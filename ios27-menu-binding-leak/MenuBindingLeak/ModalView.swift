import SwiftUI

struct ModalView: View {
    @State private var player = Player()

    var body: some View {
        Menu {
            Picker(selection: $player.playbackSpeed) {
                ForEach([0.5, 1, 1.5, 2], id: \.self) { speed in
                    Text("\(speed, specifier: "%g×")").tag(speed)
                }
            } label: {
                Text("Speed")
            }
            .pickerStyle(.inline)
        } label: {
            Text("Menu")
        }
    }
}

