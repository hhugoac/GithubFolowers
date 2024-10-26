//
//  HttpClient.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//
import Foundation

final class HttpClient {
    static let shared = HttpClient()
    let decoder = JSONDecoder()
    //private let cache =
    
    private init() {
        decoder.keyDecodingStrategy  = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    enum HttpClientError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: GFRequest,
        expecing type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(HttpClientError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            [weak self] data, _, error in
            guard let self else { return }
            guard let data = data, error == nil else {
                completion(.failure(HttpClientError.failedToGetData))
                return
            }
            
            do{
                print("🚩🚩🚩 \(String(describing: type))")
                let result = try self.decoder.decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func request(from request: GFRequest) -> URLRequest? {
        guard let url = request.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
