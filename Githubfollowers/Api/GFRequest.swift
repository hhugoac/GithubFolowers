//
//  GFRequest.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import Foundation

final class GFRequest {
    
    private struct Constants {
        static let baseUrl = "https://api.github.com"
    }
    
    private let endpoint: GFEndpoint
    
    private let queryParameter: [URLQueryItem]
    
    private let pathComponents: [String]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParameter.isEmpty {
            string += "?"
            let argumentString = queryParameter.compactMap( {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
        }
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    ///Desired http method
    public let httpMethods = "GET"
    
    // MARK: - Public
    /// Construct request
    /// - Parameters:
    ///     - endpoint: Target endpoint
    ///     - pathComponents: Collections of path components
    ///     - queryParameter: Collections of query  parameters
    init(endpoint: GFEndpoint, queryParameter: [URLQueryItem] = [], pathComponents: [String] = []) {
        self.endpoint = endpoint
        self.queryParameter = queryParameter
        self.pathComponents = pathComponents
    }
    convenience init?(url:URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let gFEndpoint = GFEndpoint(rawValue: endPointString) {
                    self.init(endpoint: gFEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endPointString = components[0]
                let queryItemsString = components[1]
                let querItem: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let gfEndpoint = GFEndpoint(rawValue: endPointString) {
                    self.init(endpoint:gfEndpoint,  queryParameter: querItem)
                    return
                }
            }
        }
        return nil
    }
}

extension GFRequest {
    static let userInfo = GFRequest(endpoint: .users)
}
