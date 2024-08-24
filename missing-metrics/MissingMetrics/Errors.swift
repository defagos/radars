import Foundation

struct DRMError: LocalizedError {
    static let missingContentKeyContext = Self(errorDescription: "The DRM license could not be retrieved")

    let errorDescription: String?
}

struct DataError: LocalizedError {
    let errorDescription: String?

    static func http(from response: URLResponse) -> Self? {
        guard let httpResponse = response as? HTTPURLResponse else { return nil }
        return http(withStatusCode: httpResponse.statusCode)
    }

    static func http(withStatusCode statusCode: Int) -> Self? {
        guard statusCode >= 400 else { return nil }
        return .init(errorDescription: HTTPURLResponse.localizedString(forStatusCode: statusCode))
    }
}
