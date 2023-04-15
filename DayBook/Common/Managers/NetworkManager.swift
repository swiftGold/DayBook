import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkManager {
    private let jsonService: JSONDecoderManagerProtocol
    init(jsonService: JSONDecoderManagerProtocol) {
        self.jsonService = jsonService
    }
}

//MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.setValue("$2b$10$vkzLeYy2GBEgh6PmDUS0D.W4qgcDkoYvZfNiBm5ZeFxUXx2C/i4zG", forHTTPHeaderField: "X-Master-Key")
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                let myError = NSError(domain: "my error domain", code: -123, userInfo: nil)
                completion(.failure(myError))
                return
            }
            self.jsonService.decode(data, completion: completion)
        }
        task.resume()
    }
}
