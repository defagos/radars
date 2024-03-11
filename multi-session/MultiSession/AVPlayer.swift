import AVFoundation

extension AVPlayer {
    func togglePlayPause() {
        if rate == 0 {
            play()
        }
        else {
            pause()
        }
    }
}
