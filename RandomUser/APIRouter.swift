//
//  APIRouter.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Encodable]? { get }
}

enum Router: APIRouter {
    
    case fetchUsers(page: Int, results: Int)
    
    var method: HTTPMethod {
        switch self {
        case .fetchUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "/api/"
        }
    }
    
    var parameters: [String: Encodable]? {
        switch self {
        case let .fetchUsers(page, results):
            return ["page": page, "results": results]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try "https://randomuser.me".asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.method = method
        
        switch method {
        case .get:
            if let parameters = parameters {
                var components = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { (key, value) in
                    return URLQueryItem(name: key, value: "\(value)")
                }
                request.url = components?.url
            }
        default:
            break
        }
        
        return request
    }
}

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    func performRequest<T:Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>) -> Void) {
        AF.request(route).responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
