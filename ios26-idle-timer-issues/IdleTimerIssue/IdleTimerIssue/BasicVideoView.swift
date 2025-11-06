import AVFoundation
import SwiftUI

struct BasicVideoView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> VideoLayerView {
        .init()
    }

    func updateUIView(_ uiView: VideoLayerView, context: Context) {
        uiView.player = player
    }
}

final class VideoLayerView: UIView {
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    private var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}

