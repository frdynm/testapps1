import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingFailed
    case serverError(code: Int, message: String?)
    case networkUnavailable
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .decodingFailed: return "Decoding failed"
        case .serverError(let c, let m): return "Server error \(c): \(m ?? "Unknown")"
        case .networkUnavailable: return "Network unavailable"
        case .unknown(let e): return e.localizedDescription
        }
    }
}

@preconcurrency protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}
