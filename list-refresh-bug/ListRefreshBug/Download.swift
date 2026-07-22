import Combine
import Foundation

final class Download: ObservableObject, Identifiable {
    let id: String

    @Published private(set) var progress: Double = 0

    init(id: String) {
        self.id = id

        stride(from: 0, to: 1.1, by: 0.1)
            .publisher
            .flatMap(maxPublishers: .max(1)) { value in
                Just(value)
                    .delay(for: .milliseconds(Int.random(in: 1000...3000)), scheduler: DispatchQueue.main)
            }
            .assign(to: &$progress)
    }

    deinit {
        print("--> deinit \(id)")
    }
}

extension Download: Equatable {
    static func == (lhs: Download, rhs: Download) -> Bool {
        lhs.id == rhs.id
    }
}
