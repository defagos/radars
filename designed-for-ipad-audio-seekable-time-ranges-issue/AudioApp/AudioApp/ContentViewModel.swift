import AVFoundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published private var loadedTimeRange: CMTimeRange = .zero
    @Published private var seekableTimeRange: CMTimeRange = .zero

    let player = AVPlayer(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13306839/63cc2653-8305-3894-a448-108810b553ef.mp3")!)

    init() {
        timeRangePublisher(for: \.loadedTimeRanges)
            .receive(on: DispatchQueue.main)
            .assign(to: &$loadedTimeRange)
        timeRangePublisher(for: \.seekableTimeRanges)
            .receive(on: DispatchQueue.main)
            .assign(to: &$seekableTimeRange)
    }

    var loadedRangeString: String {
        "[\(loadedTimeRange.start.seconds), \(loadedTimeRange.end.seconds)]"
    }

    var seekableRangeString: String {
        "[\(seekableTimeRange.start.seconds), \(seekableTimeRange.end.seconds)]"
    }

    func play() {
        player.play()
    }

    private func timeRangePublisher(for keyPath: KeyPath<AVPlayerItem, [NSValue]>) -> AnyPublisher<CMTimeRange, Never> {
        player
            .publisher(for: \.currentItem)
            .map { item -> AnyPublisher<[NSValue], Never> in
                guard let item else { return Just([]).eraseToAnyPublisher() }
                return item.publisher(for: keyPath).eraseToAnyPublisher()
            }
            .switchToLatest()
            .map { timeRanges in
                guard let first = timeRanges.first?.timeRangeValue, let last = timeRanges.last?.timeRangeValue else { return .zero }
                return CMTimeRange(start: first.start, end: last.end)
            }
            .eraseToAnyPublisher()
    }


}
