import Foundation
import Combine

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case HEAD
}

enum HttpRequestHeaderKey: String {
    case x_csrf_Token = "X-CSRF-Token"
    case x_http_method = "x-http-method"
    case x_sup_sc = "X-SUP-SC"
    case content_type = "Content-Type"
    case accept = "accept"
}

typealias Networking = (Endpoint) -> Future<Data, Error>

protocol Endpoint {

    var host: String { get }

    var path: String { get }

    var queryItems: [URLQueryItem]? { get }
    
    var httpMethod: HttpMethod { get set }

    var url: URL? { get }
    
    var request: URLRequest? { get }
    
    var httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? { get set }
    
    var body: Data? { get set }
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.host
        components.path = self.path
        components.port = 8080
        if !(queryItems?.isEmpty ?? true){
            components.queryItems = self.queryItems
        }
        return components.url
    }
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod  = self.httpMethod.rawValue
        
        if let httpHeaders = httpHeaders {
            httpHeaders.forEach { (header) in
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
            }
        }
        
        if let body = body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}
