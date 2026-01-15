import Combine
import SwiftUI

struct TimeView: View {
    @StateObject private var model = TimeViewModel()

    var body: some View {
        Text("\(model.date)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                print("--> Appear")
            }
            .onDisappear {
                print("--> Disappear")
            }
    }
}

private final class TimeViewModel: ObservableObject {
    @Published private(set) var date = Date()

    init() {
        print("--> Init View Model")
        Self.timerPublisher()
            .assign(to: &$date)
    }

    private static func timerPublisher() -> AnyPublisher<Date, Never> {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
}
