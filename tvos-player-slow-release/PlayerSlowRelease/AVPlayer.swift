import AVFoundation

extension AVPlayer {
    func cancelLoadingAndReplaceCurrentItem(with item: AVPlayerItem) {
#if os(tvOS)
        let previousItem = currentItem
        replaceCurrentItem(with: item)
        if let previousItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                previousItem.asset.cancelLoading()
            }
        }
#else
        replaceCurrentItem(with: item)
#endif
    }
}
