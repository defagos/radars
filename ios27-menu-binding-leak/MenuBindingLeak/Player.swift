import Observation

@Observable
final class Player {
    var playbackSpeed: Double = 1

    deinit {
        print("--> deinit")
    }
}
