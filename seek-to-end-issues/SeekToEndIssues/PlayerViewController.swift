import AVFoundation
import Combine
import UIKit

final class PlayerViewController: UIViewController {
    // Videos
    private let player = AVQueuePlayer(items: [
        .init(url: URL(string: "https://rts-vod-amd.akamaized.net/ww/13444447/c1d17174-ad2f-31c2-a084-846a9247fd35/master.m3u8")!),
        .init(url: URL(string: "https://rts-vod-amd.akamaized.net/ww/13444352/32145dc0-b5f8-3a14-ae11-5fc6e33aaaa4/master.m3u8")!),
        .init(url: URL(string: "https://rts-vod-amd.akamaized.net/ww/13444409/23f808a4-b14a-3d3e-b2ed-fa1279f6cf01/master.m3u8")!),
        .init(url: URL(string: "https://rts-vod-amd.akamaized.net/ww/13444371/3f26467f-cd97-35f4-916f-ba3927445920/master.m3u8")!),
        .init(url: URL(string: "https://rts-vod-amd.akamaized.net/ww/13444428/857d97ef-0b8e-306e-bf79-3b13e8c901e4/master.m3u8")!)
    ])

    // Audios
//    private let player = AVQueuePlayer(items: [
//        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13605286/4b41aaec-e159-35bd-a0c8-5e9f4d826f75.mp3")!),
//        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13598743/d96d95c9-23cf-38b8-92af-42e89cd85afa.mp3")!),
//        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13579611/cbb735b0-3b77-3a0f-9061-4c8ab0fa9927.mp3")!),
//        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13605216/a323e7e4-4c0a-3455-aed4-49b3c02f73fa.mp3")!)
//    ])

    private var observer: Any?
    private var isInteracting = false
    private var cancellables = Set<AnyCancellable>()
    private var seekCount = 0 {
        didSet {
            updateSeekCountLabel(withCount: seekCount)
        }
    }

    private weak var activityIndicatorView: UIActivityIndicatorView!
    private weak var seekCountLabel: UILabel!

    private var timeRange: CMTimeRange? {
        guard let currentItem = player.currentItem else { return nil }
        let loadedTimeRanges = currentItem.loadedTimeRanges
        let seekableTimeRanges = currentItem.seekableTimeRanges
        guard let firstRange = seekableTimeRanges.first?.timeRangeValue, !firstRange.isIndefinite,
              let lastRange = seekableTimeRanges.last?.timeRangeValue, !lastRange.isIndefinite else {
            return !loadedTimeRanges.isEmpty ? .zero : nil
        }
        return CMTimeRangeFromTimeToTime(start: firstRange.start, end: lastRange.end)
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .black
        configurePlayerView(in: view)
        configureSlider(in: view)
        configureActivityIndicatorView(in: view)
        configureSeekCountLabel(in: view)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        player.publisher(for: \.currentItem)
            .sink { item in
                if let item {
                    print("--> item changed to \(item)")
                }
                else {
                    print("--> item changed to nil")
                }
            }
            .store(in: &cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        player.play()
    }

    private func configurePlayerView(in view: UIView) {
        let playerView = PlayerView()
        playerView.playerLayer.player = player
        view.addSubview(playerView)

        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureSlider(in view: UIView) {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderBegan(_:)), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderEnded(_:)), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderEnded(_:)), for: .touchUpInside)
        slider.minimumValue = 0
        view.addSubview(slider)

        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])

        player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 10), queue: nil) { [weak slider, weak self] time in
            guard let self, !self.isInteracting, let slider else { return }
            if let timeRange = self.timeRange {
                slider.maximumValue = 1
                slider.value = Float((time - timeRange.start).seconds / timeRange.duration.seconds)
            }
            else {
                slider.maximumValue = 0
                slider.value = 0
            }
        }
    }

    private func configureActivityIndicatorView(in view: UIView) {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .white
        view.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        player.publisher(for: \.currentItem)
            .map { item in
                guard let item else { return Just(false).eraseToAnyPublisher() }
                return item.publisher(for: \.isPlaybackLikelyToKeepUp).eraseToAnyPublisher()
            }
            .switchToLatest()
            .prepend(false)
            .sink { isPlaybackLikelyToKeepUp in
                activityIndicatorView.isHidden = isPlaybackLikelyToKeepUp
            }
            .store(in: &cancellables)
    }

    private func configureSeekCountLabel(in view: UIView) {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .blue
        view.addSubview(label)
        self.seekCountLabel = label

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        updateSeekCountLabel(withCount: seekCount)
    }

    private func updateSeekCountLabel(withCount count: Int) {
        seekCountLabel.text = "Seeks: \(count)"
    }

    @IBAction private func sliderBegan(_ sender: UISlider) {
        isInteracting = true
    }

    @IBAction private func sliderMoved(_ sender: UISlider) {
        guard let timeRange = self.timeRange else { return }
        let time = timeRange.start + CMTimeMultiplyByFloat64(timeRange.duration, multiplier: Float64(sender.value))
        seekCount += 1
        player.seek(to: time) { [weak self] finished in
            self?.seekCount -= 1
        }
    }

    @IBAction private func sliderEnded(_ sender: UISlider) {
        isInteracting = false
    }

    deinit {
        if let observer {
            player.removeTimeObserver(observer)
        }
    }
}
