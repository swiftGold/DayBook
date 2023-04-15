protocol APIServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[TaskModel], Error>) -> Void)
}

final class APIService {
    
    private let networkManager: NetworkManagerProtocol
    
    init(
        networkManager: NetworkManagerProtocol
    ) {
        self.networkManager = networkManager
    }
}

//MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[TaskModel], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        networkManager.request(urlString: urlString, completion: completion)
    }
}
