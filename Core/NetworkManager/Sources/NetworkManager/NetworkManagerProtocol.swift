import Foundation

// MARK: - Network Error
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingFailed
    case serverError(code: Int, message: String?)
    case networkUnavailable
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .decodingFailed:
            return "Failed to decode response"
        case .serverError(let code, let message):
            return "Server error \(code): \(message ?? "Unknown error")"
        case .networkUnavailable:
            return "Network is unavailable"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Network Result
typealias NetworkResult<T: Decodable> = Result<T, NetworkError>

// MARK: - Network Manager Protocol
protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}
