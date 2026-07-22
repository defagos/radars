import SwiftUI

struct DownloadCell: View {
    @ObservedObject var download: Download

    var body: some View {
        VStack(alignment: .leading) {
            Text(download.id)
            ProgressView(value: download.progress)
        }
    }
}
