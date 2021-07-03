//
//  APIClient.swift
//  SearchReposApp
//
//  Created by toka mohsen on 02/07/2021.
//

import Foundation
class APIClient<T: Decodable> {
    static func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                // we can classify error here before return it if we have error handling
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
