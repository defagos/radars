import AVFoundation
import MediaPlayer

final class PlaybackContext {
    private let title: String
    let player: AVPlayer
    private let session: MPNowPlayingSession

    init(title: String, url: URL) {
        self.title = title
        self.player = AVPlayer(url: url)
        self.session = MPNowPlayingSession(players: [player])
        configureSession()
    }

    private func configureSession() {
        session.nowPlayingInfoCenter.nowPlayingInfo = [
            MPMediaItemPropertyTitle: title
        ]
        session.remoteCommandCenter.playCommand.addTarget { [player] _ in
            player.play()
            return .success
        }
        session.remoteCommandCenter.pauseCommand.addTarget { [player] _ in
            player.pause()
            return .success
        }
        session.remoteCommandCenter.togglePlayPauseCommand.addTarget { [player] _ in
            player.togglePlayPause()
            return .success
        }
    }

    func becomeActiveIfPossible() {
        session.becomeActiveIfPossible()
    }
}
