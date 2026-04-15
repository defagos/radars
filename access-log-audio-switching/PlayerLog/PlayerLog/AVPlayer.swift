import AVFoundation

extension AVPlayer {
    func printAccessLog() {
        guard let accessLog = currentItem?.accessLog(),
              let data = accessLog.extendedLogData(),
              let log = String(data: data, encoding: .utf8) else {
            return
        }
        print("--> Access log with \(accessLog.events.count) entries: \(log)\n\n\n\n")
    }
}
