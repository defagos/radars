import Foundation

extension URLSession {
    func httpData(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(for: request, delegate: delegate)
        if let httpError = DataError.http(from: response) {
            throw httpError
        }
        return (data, response)
    }

    func httpData(from url: URL, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(from: url, delegate: delegate)
        if let httpError = DataError.http(from: response) {
            throw httpError
        }
        return (data, response)
    }
}
