//
//  Service.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import Foundation

/// Primary API service object to get Placeholder data
final class Service {
    
    /// Shared singleton instance
    static let shared = Service()
    
    
    /// Privatized constructor
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData

    }
        
        
        /// Send  API Call
        /// - Parameters:
        ///   - request: Request instance
        ///   - type: The type of object we expect to get back
        ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            guard let data = data, error == nil else {
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                            print("Failed to fetch data from URL: \(urlRequest.url?.absoluteString ?? "Unknown URL") with error: \(errorMessage)")
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
                //
            }
            catch {
                print("Failed to decode data from URL: \(urlRequest.url?.absoluteString ?? "Unknown URL") with error: \(error.localizedDescription)")

                completion(.failure(error))
            }
        }
        task.resume()
        }
    
    
    // MARK: - Private
    
    private func request(from Request: Request) -> URLRequest? {
        guard let url = Request.url else {
            return nil
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = Request.httpMethod
        return request
    }
    
}
