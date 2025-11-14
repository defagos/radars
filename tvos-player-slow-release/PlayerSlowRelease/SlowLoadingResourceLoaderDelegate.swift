import AVFoundation

final class SlowLoadingResourceLoaderDelegate: NSObject, AVAssetResourceLoaderDelegate {
    func resourceLoader(
        _ resourceLoader: AVAssetResourceLoader,
        shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest
    ) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
            loadingRequest.finishLoading()
        }
        return true
    }

    func resourceLoader(
        _ resourceLoader: AVAssetResourceLoader,
        shouldWaitForRenewalOfRequestedResource renewalRequest: AVAssetResourceRenewalRequest
    ) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
            renewalRequest.finishLoading()
        }
        return true
    }

    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
        print("--> resource loader did cancel")
    }

    deinit {
        print("--> resource loader delegate deinit")
    }
}
