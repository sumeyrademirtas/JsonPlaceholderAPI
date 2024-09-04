//
//  Request.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import Foundation

/// Object that represents a single API call
final class Request {


    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://jsonplaceholder.typicode.com"
    }
    
    
    /// Desired endpoint
    private let endpoint: PhEndPoint
    
    
    /// Path components for API, if any
    private let pathComponents: [String]
    
    
    /// Query arguements for API, if any
    private let queryParameters: [URLQueryItem]
    
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach( {
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // name = value&name=value
            let arguementString = queryParameters.compactMap( {
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += arguementString
        }
        
        return string
    }
    
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Desired http method
    public let httpMethod = "GET"
    
    
    
    // MARK: - Public
    
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: PhEndPoint,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
    /// Attemt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
            let string = url.absoluteString
            
            // Check if it starts with the base URL
            guard string.contains(Constants.baseUrl) else {
                print("ERROR: URL does not contain the base URL: \(string)")
                return nil
            }
            
            // Trim the base URL from the rest of the string
            let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
            
            // Check if there are path components in the URL
            if trimmed.contains("/") {
                let components = trimmed.components(separatedBy: "/")
                guard !components.isEmpty else {
                    print("ERROR: URL path components error: \(trimmed)")
                    return nil
                }
                
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let phEndpoint = PhEndPoint(rawValue: endpointString) {
                    self.init(endpoint: phEndpoint, pathComponents: pathComponents)
                    return
                } else {
                    print("ERROR: Could not determine endpoint: \(endpointString)")
                    return nil
                }
                
            // Check if there are query parameters in the URL
            } else if trimmed.contains("?") {
                let components = trimmed.components(separatedBy: "?")
                guard !components.isEmpty else {
                    print("ERROR: URL query string error: \(trimmed)")
                    return nil
                }
                
                let endpointString = components[0]
                if let phEndpoint = PhEndPoint(rawValue: endpointString) {
                    self.init(endpoint: phEndpoint)
                    return
                } else {
                    print("ERROR: Could not determine endpoint: \(endpointString)")
                    return nil
                }
            }
            
            // If none of the above checks pass
            print("ERROR: Invalid URL format: \(string)")
            return nil
        }
    }


extension Request {
    static let listPeopleRequests = Request(endpoint: .users)
}
