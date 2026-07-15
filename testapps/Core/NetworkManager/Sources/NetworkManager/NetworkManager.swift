import Foundation

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private nonisolated(unsafe) var session: URLSession
    private nonisolated(unsafe) var decoder: JSONDecoder

    private init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    nonisolated func fetch<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        return try await fetch(type, from: url)
    }

    nonisolated func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(URLError(.badServerResponse))
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(code: httpResponse.statusCode, message: nil)
        }
        do { return try decoder.decode(type, from: data) }
        catch { throw NetworkError.decodingFailed }
    }
}
