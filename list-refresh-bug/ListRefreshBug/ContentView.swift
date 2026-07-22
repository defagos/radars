import SwiftUI

struct ContentView: View {
    @StateObject private var downloader = Downloader()

    var body: some View {
        VStack {
            list()
            itemManagementView()
        }
        .navigationTitle("Downloads")
    }

    private func list() -> some View {
        List(downloader.downloads) { download in
            DownloadCell(download: download)
        }
    }

    /**
     * This implementation works as expected.
     */
//    private func list() -> some View {
//        ScrollView {
//            VStack {
//                ForEach(downloader.downloads) { download in
//                    DownloadCell(download: download)
//                        .padding()
//                }
//            }
//        }
//    }

    private func itemManagementView() -> some View {
        VStack(spacing: 20) {
            ForEach(1..<4) { id in
                HStack {
                    addButton(forId: id)
                    removeButton(forId: id)
                }
            }
        }
    }

    private func addButton(forId id: Int) -> some View {
        Button {
            downloader.addDownload(id: "\(id)")
        } label: {
            Text("Add \(id)")
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity)
    }

    private func removeButton(forId id: Int) -> some View {
        Button {
            downloader.removeDownload(matchingId: "\(id)")
        } label: {
            Text("Remove \(id)")
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
