import Combine

final class Downloader: ObservableObject {
    @Published private(set) var downloads: [Download] = []

    func addDownload(id: String) {
        guard !downloads.contains(where: { $0.id == id }) else { return }
        downloads.append(.init(id: id))
    }

    func removeDownload(matchingId id: String) {
        downloads.removeAll { $0.id == id }
    }
}
